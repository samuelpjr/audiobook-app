//
//  AppComposer.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//


import Foundation

struct AppComposer {
    
    @MainActor static func composePodcastListView() -> PodcastListView {
        let apiService = PodcastService()
        let repository = PodcastRepository(apiService: apiService)
        let viewModel = PodcastListViewModel(getPodcastsUseCases: repository)
        let view = PodcastListView(viewModel: viewModel)
        return view
    }
}
