//
//  PodcastListViewModel.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import Foundation

@Observable
class PodcastListViewModel {
    
    var podcasts: [Podcast] = []
    
    var errorMessage: String? = nil
    var viewState: ViewState = .loading
    
    private let getPodcasts: PodcastRepositoryProtocol
    
    init(getPodcastsUseCases: PodcastRepositoryProtocol) {
        self.getPodcasts = getPodcastsUseCases
        
    }
    
    func fetchPodcasts() async {
        viewState = .loading
        do {
            podcasts = try await getPodcasts.executePodcasts()
            self.viewState = .loaded
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            self.viewState = .error((error as? LocalizedError)?.errorDescription ?? error.localizedDescription)
        }

    }
}
