//
//  Podcasts.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import Foundation

protocol PodcastRepositoryProtocol {
    @MainActor func executePodcasts(page: Int) async throws -> PodcastResponse
}

@MainActor
class PodcastRepository: PodcastRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func executePodcasts(page: Int) async throws -> PodcastResponse {
        try await apiService.request(endpoint: .podcastList(page: page))
    }
}
