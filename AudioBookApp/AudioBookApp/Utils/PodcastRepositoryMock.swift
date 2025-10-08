//
//  PodcastRepository.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import Foundation

class PodcastRepositoryMock: PodcastRepositoryProtocol {
    func executePodcasts() async throws -> [Podcast] {
        return []
    }
}
