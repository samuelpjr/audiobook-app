//
//  PodcastListView.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import SwiftUI

struct PodcastListView: View {
    
    @State var viewModel: PodcastListViewModel
    
    init(viewModel: PodcastListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            switch viewModel.viewState {
            case .loading:
                LoadingIndicatorView()
            case .loaded:
                List {
                    ForEach(viewModel.podcasts) { podcast in
                        NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                            PodcastListRowView(podcast: podcast)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .navigationTitle("Podcasts")
                .listStyle(.plain)
            case .error(_):
                ErrorState(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.fetchPodcasts()
        }
    }
}

#Preview {
    let podcastListView = AppComposer.composePodcastListView()
    podcastListView
        .environment(FavouritesManager())
    
}
