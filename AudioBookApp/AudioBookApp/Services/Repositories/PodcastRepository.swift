//
//  Podcasts.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//


protocol PodcastRepositoryProtocol {
    @MainActor func executePodcasts() async throws -> [Podcast]
}

@MainActor
class PodcastRepository: PodcastRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func executePodcasts() async throws -> [Podcast] {
        let podcastResponse: PodcastResponse = try await apiService.request(endpoint: .podcastList)
        return podcastResponse.podcasts
    }
}
