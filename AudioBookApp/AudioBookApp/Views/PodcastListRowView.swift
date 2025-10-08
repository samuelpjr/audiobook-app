//
//  PodcastListRowView.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import SwiftUI

struct PodcastListRowView: View {
    
    @State var podcast: Podcast
    @Environment(FavouritesManager.self) private var favourites
    
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: podcast.thumbnail)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading){
                Text(podcast.title)
                    .font(.headline).fontWeight(.bold)
                Text(podcast.publisher)
                    .font(.footnote).foregroundStyle(.gray)
                Text("Favourited")
                    .foregroundStyle(.red)
                    .visible(favourites.isFavourited(podcast))
            }
        }
    }
}

#Preview {
    PodcastListRowView(podcast: Podcast.mock)
        .environment(FavouritesManager())
}
