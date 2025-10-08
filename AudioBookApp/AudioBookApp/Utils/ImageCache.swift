//
//  ImageCache.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-08.
//

import SwiftUI

/// A lightweight in-memory cache for storing and retrieving downloaded images.
///
/// `ImageCache` uses `NSCache` under the hood to cache images in memory,
/// improving performance and reducing redundant network requests for thumbnails
/// or other remote images.
///
/// This class is implemented as a singleton (`ImageCache.shared`)
/// so that all parts of the app share the same image cache.
///
/// Example usage:
/// ```swift
/// // Retrieve an image if it exists in cache
/// if let cachedImage = ImageCache.shared.image(for: url) {
///     imageView.image = cachedImage
/// } else {
///     // Download the image and store it in the cache
///     downloadImage(from: url) { image in
///         ImageCache.shared.insertImage(image, for: url)
///         imageView.image = image
///     }
/// }
/// ```
///
/// - Note: `NSCache` automatically manages memory by purging its contents
///   when the system is under memory pressure, so you don't need to manually clear it.
/// - Important: This cache only persists during the app session.
///   Once the app is closed, cached images are lost.
///
final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return }
        cache.setObject(image, forKey: url as NSURL)
    }
}
