//
//  PodcastListViewModel.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import Foundation

@Observable
class PodcastListViewModel {
    
    var displayedPodcasts: [Podcast] = []
    private var allFetchedPodcasts: [Podcast] = []
    
    private(set) var hasNextPage = true
    private var currentPage = 1
    private var pageNumber = 1
    private let pageSize = 10
    private var currentDisplayIndex = 0
    
    var errorMessage: String? = nil
    var viewState: ViewState = .idle
    
    private let getPodcasts: PodcastRepositoryProtocol
    
    init(getPodcastsUseCases: PodcastRepositoryProtocol) {
        self.getPodcasts = getPodcastsUseCases
        
    }
    
    func loadInitialPage() async {
        currentPage = 1
        pageNumber = 1
        currentDisplayIndex = 0
        hasNextPage = true
        displayedPodcasts.removeAll()
        allFetchedPodcasts.removeAll()
        await loadPage()
    }
    
    private func loadPage() async {
        guard !viewState.isLoading else { return }
        
        viewState = .loading
        defer { viewState = .loaded }
        
        if currentPage > pageNumber {
            return
        }
        
        do {
            let response = try await getPodcasts.executePodcasts(page: currentPage)
            allFetchedPodcasts = response.podcasts
            setupPagination(response)
            loadMoreItemsFromCurrentPage()
        } catch {
            self.viewState = .error((error as? LocalizedError)?.errorDescription ?? error.localizedDescription)
        }
    }
    
    func loadMoreIfNeeded(currentItem: Podcast?) async {
        guard !viewState.isLoading else { return }
        
        if let currentItem = currentItem,
           displayedPodcasts.last?.id == currentItem.id {
            
            if currentDisplayIndex < allFetchedPodcasts.count {
                loadMoreItemsFromCurrentPage()
            }
            
            else if hasNextPage {
                currentPage += 1
                await loadPage()
            }
        }
    }
    
    private func loadMoreItemsFromCurrentPage() {
        let nextIndex = min(currentDisplayIndex + pageSize, allFetchedPodcasts.count)
        let nextSlice = allFetchedPodcasts[currentDisplayIndex..<nextIndex]
        displayedPodcasts.append(contentsOf: nextSlice)
        currentDisplayIndex = nextIndex
    }
    
    private func setupPagination(_ response: PodcastResponse) {
        pageNumber = response.pageNumber
        hasNextPage = response.hasNext
        currentPage = response.nextPageNumber
    }
}
