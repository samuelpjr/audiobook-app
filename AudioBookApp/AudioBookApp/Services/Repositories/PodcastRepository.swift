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

/// Repository responsible for fetching podcast data from the API.
///
/// `PodcastRepository` acts as an abstraction layer between the network service
/// and the ViewModel. It encapsulates the logic for requesting podcasts
/// and returning strongly-typed models to the caller, allowing the ViewModel
/// to remain independent of the networking implementation.
///
/// Example usage:
/// ```swift
/// let repository = PodcastRepository(apiService: PodcastService())
/// let response = try await repository.executePodcasts(page: 1)
/// print(response.podcasts)
/// ```
///
/// - Note: This repository currently only supports fetching the best podcasts
///   using pagination. Additional methods could be added for search or filtering.
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
