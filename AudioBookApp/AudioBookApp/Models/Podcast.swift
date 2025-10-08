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
    let nextPageNumber, previousPageNumber, pageNumber: Int
}

struct Podcast: Decodable, Identifiable {
    let id: String
    let title: String
    let publisher: String
    let image: String
    let thumbnail: String
    let description: String
}


extension Podcast {
    static var mock = Podcast(id: "1", title: "THE ED MYLETT SHOW", publisher: "Ed Mylett | Cumulus Podcast Network", image: "https://cdn-images-3.listennotes.com/podcasts/the-ed-mylett-show-ed-mylett-cumulus-guxpvEVnHTJ-PEUIT9RBhZD.1400x1400.jpg", thumbnail: "https://cdn-images-3.listennotes.com/podcasts/the-ed-mylett-show-ed-mylett-cumulus-vQDCWVsEFw2-PEUIT9RBhZD.300x300.jpg", description: "The Ed Mylett Show showcases the greatest peak-performers across all industries in one place, sharing their journey, knowledge and thought leadership. With Ed Mylett and featured guests in almost every industry including business, health, collegiate and professional sports, politics, entrepreneurship, science, and entertainment, you'll find motivation, inspiration and practical steps to help you become the best version of you!")
}
