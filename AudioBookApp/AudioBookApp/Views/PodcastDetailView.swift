//
//  PodcastDetailView.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import SwiftUI

struct PodcastDetailView: View {
    
    @State var podcast: Podcast
    @Environment(FavouritesManager.self) private var favourites
    @State private var scale: CGFloat = 1.0
    
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 25) {
                Text(podcast.title)
                    .font(.title).fontWeight(.bold)
                Text(podcast.publisher)
                    .font(.subheadline).foregroundStyle(.gray)
                AsyncImage(url: URL(string: podcast.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 60, height: 60)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 160)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                Button(buttonTitle) {
                    favourites.toggleFavourite(podcast)
                    scale = buttonSize
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .background(isFavourite ? Color.gray : Color.pink)
                .cornerRadius(10)
                .scaleEffect(scale)
                .animation(.bouncy, value: scale)
                
                Text(podcast.description)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 20)
            }
        }
        .onAppear {
            scale = buttonSize
        }
    }
    
    var isFavourite: Bool {
        favourites.isFavourited(podcast)
    }
    
    var buttonTitle: String {
        isFavourite ? "Favourited" : "Favourite"
    }
    
    var buttonSize: CGFloat {
        isFavourite ? 0.9 : 1.2
    }
}

#Preview {
    PodcastDetailView(podcast: Podcast.mock)
        .environment(FavouritesManager())
}
