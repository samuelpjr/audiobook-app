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
            CachedAsyncImage(url: podcast.thumbnail) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
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
        .padding(.vertical, 10)
    }
}

#Preview {
    PodcastListRowView(podcast: Podcast.mock)
        .environment(FavouritesManager())
}
