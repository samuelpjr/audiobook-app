//
//  LoadingIndicatorView.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//


import SwiftUI

struct LoadingIndicatorView: View {
    var body: some View {
        ProgressView("Loading Podcasts...")
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
    }
}

#Preview {
    LoadingIndicatorView()
}
