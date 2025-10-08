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
                podcastListContent
            case .error(_):
                ErrorState(viewModel: viewModel)
            case .idle:
                LoadingIndicatorView()
            }
        }
        .task {
            await viewModel.loadInitialPage()
        }
    }
}

// MARK: - View component
extension PodcastListView {
    var podcastListContent: some View {
        List {
            ForEach(viewModel.displayedPodcasts) { podcast in
                NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                    PodcastListRowView(podcast: podcast)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreIfNeeded(currentItem: podcast)
                            }
                        }
                }
                .listRowSeparator(.hidden)
            }
        }
        .navigationTitle("Podcasts")
        .listStyle(.plain)
    }
}

#Preview {
    let podcastListView = AppComposer.composePodcastListView()
    podcastListView
        .environment(FavouritesManager())
    
}
