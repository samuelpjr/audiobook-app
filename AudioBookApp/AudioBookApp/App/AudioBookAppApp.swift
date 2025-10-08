//
//  AudioBookAppApp.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import SwiftUI

@main
struct AudioBookAppApp: App {
    
    private let favourites = FavouritesManager()
    
    var body: some Scene {
        WindowGroup {
            let podcastListView = AppComposer.composePodcastListView()
            podcastListView
                .environment(favourites)
        }
    }
}
