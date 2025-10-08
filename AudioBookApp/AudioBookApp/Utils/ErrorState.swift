//
//  ErrorState.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//


import SwiftUI

struct ErrorState: View {
    
    let viewModel: PodcastListViewModel
    
    init(viewModel: PodcastListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("Error: \(String(describing: viewModel.errorMessage))")
                .font(.headline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            Button("Retry") {
                Task {
                    await viewModel.loadInitialPage()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            .foregroundColor(.white)
        }
    }
}

#Preview {
    let usecases: PodcastRepositoryProtocol = PodcastRepositoryMock()
    let viewModel = PodcastListViewModel(getPodcastsUseCases: usecases)
    ErrorState(viewModel: viewModel)
}
