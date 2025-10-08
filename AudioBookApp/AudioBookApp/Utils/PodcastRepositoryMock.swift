//
//  PodcastRepository.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import Foundation


/// Mock to use on preview and tests
class PodcastRepositoryMock: PodcastRepositoryProtocol {
    @MainActor
    func executePodcasts(page: Int) async throws -> PodcastResponse {
        let podcasts = [
            Podcast.mock,
            Podcast(id: "2", title: "Swift by Sundell", publisher: "John Sundell", image: "https://example.com/image2.jpg", thumbnail: "https://example.com/thumb2.jpg", description: "A podcast about Swift development."),
            Podcast(id: "3", title: "Accidental Tech Podcast", publisher: "ATP", image: "https://example.com/image3.jpg", thumbnail: "https://example.com/thumb3.jpg", description: "A tech podcast we accidentally created.")
        ]
        
        return PodcastResponse(
            name: "Mock Page \(page)",
            hasNext: page < 3,
            podcasts: podcasts,
            hasPrevious: page > 1,
            nextPageNumber: page + 1,
            previousPageNumber: max(1, page - 1),
            pageNumber: 2
        )
    }
}
