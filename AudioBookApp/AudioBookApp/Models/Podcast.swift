//
//  Podcast.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

struct PodcastResponse: Decodable {
    let name: String
    let hasNext: Bool
    let podcasts: [Podcast]
    let hasPrevious: Bool
    let nextPageNumber, previousPageNumber: Int
}

struct Podcast: Decodable, Identifiable {
    let id: String
    let title: String
    let publisher: String
    let image: String
    let thumbnail: String
    let description: String
}

