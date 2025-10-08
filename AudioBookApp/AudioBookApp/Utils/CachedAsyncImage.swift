//
//  CachedAsyncImage.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-08.
//

import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    private let url: URL
    private let content: (Image) -> Content

    init(url: String, @ViewBuilder content: @escaping (Image) -> Content) {
        self.url = URL(string: url)!
        self.content = content
    }

    @State private var uiImage: UIImage?

    var body: some View {
        if let uiImage = uiImage {
            content(Image(uiImage: uiImage))
        } else {
            ProgressView()
                .task {
                    await loadImage()
                }
        }
    }

    private func loadImage() async {
        if let cached = ImageCache.shared.image(for: url) {
            uiImage = cached
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                ImageCache.shared.insertImage(image, for: url)
                await MainActor.run {
                    uiImage = image
                }
            }
        } catch {
            print("Failed to load image: \(error)")
        }
    }
}
