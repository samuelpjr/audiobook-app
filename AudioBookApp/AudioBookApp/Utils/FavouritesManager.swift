//
//  FavouritesManager.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import Foundation

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
