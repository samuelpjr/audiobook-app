//
//  FavouritesManager.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import Foundation

/// A manager responsible for handling favourite podcasts within the app.
///
/// `FavouritesManager` provides an easy way to persist and retrieve
/// a list of favourited podcasts using `UserDefaults`.
/// It supports adding, removing, and checking favourite status by podcast ID.
///
/// This class is inject by environment
/// so that the favourite state can be accessed consistently across the app.
///
/// Example usage:
/// ```swift
/// // Add and Remove podcast to favourites
/// toggleFavourite(_ podcast: Podcast)
/// // Check if a podcast is favourited
/// let isFavourited = isFavourited(_ podcast: Podcast) -> Bool
/// ```
///
/// - Note: The favourite state is persisted locally using `UserDefaults`
///   and will remain between app launches, but it is not synced across devices.
/// - Important: Ensure that each podcast has a unique and stable `id`
///   property for the favourite logic to work correctly.
///
@Observable
final class FavouritesManager  {
    private(set) var favourites: Set<String> = []
    private let key = "favourite_podcasts"
    
    init() {
        loadFavourites()
    }
    
    func isFavourited(_ podcast: Podcast) -> Bool {
        favourites.contains(podcast.id)
    }
    
    func toggleFavourite(_ podcast: Podcast) {
        if favourites.contains(podcast.id) {
            favourites.remove(podcast.id)
        } else {
            favourites.insert(podcast.id)
        }
        saveFavourites()
    }
    
    private func loadFavourites() {
        if let saved = UserDefaults.standard.array(forKey: key) as? [String] {
            favourites = Set(saved)
        }
    }
    
    private func saveFavourites() {
        UserDefaults.standard.set(Array(favourites), forKey: key)
    }
}
