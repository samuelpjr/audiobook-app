//
//  AppComposer.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//


import Foundation

/// Central composition root for dependency injection.
///
/// Assembles and injects dependencies for the main podcast list feature,
/// wiring together service, repository, and ViewModel layers.
struct AppComposer {
    
    /// Creates and composes the `PodcastListView` with all its dependencies.
    /// - Returns: A fully initialized `PodcastListView`.
    @MainActor static func composePodcastListView() -> PodcastListView {
        let apiService = PodcastService()
        let repository = PodcastRepository(apiService: apiService)
        let viewModel = PodcastListViewModel(getPodcastsUseCases: repository)
        let view = PodcastListView(viewModel: viewModel)
        return view
    }
}
