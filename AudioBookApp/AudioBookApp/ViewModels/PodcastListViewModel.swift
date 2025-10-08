//
//  PodcastListViewModel.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import Foundation

/// ViewModel responsible for managing podcast list state.
/// Handles pagination, favorite status, and network loading.
///
/// This ViewModel is observed by `PodcastListView` to display podcasts reactively
@Observable
class PodcastListViewModel {
    
    // MARK: - public properties
    
    /// The current list of podcasts displayed in the view.
    var displayedPodcasts: [Podcast] = []
    
    /// View state
    var errorMessage: String? = nil
    var viewState: ViewState = .idle
    
    // MARK: - private properties
    private var allFetchedPodcasts: [Podcast] = []
    
    /// Pagination properties
    private var hasNextPage = true
    private var currentPage = 1
    private var pageNumber = 1
    private var currentDisplayIndex = 0
    private let pageSize = 10
    
    /// Dependencies
    private let getPodcasts: PodcastRepositoryProtocol
    
    // MARK: - Init and dependencies
    init(getPodcastsUseCases: PodcastRepositoryProtocol) {
        self.getPodcasts = getPodcastsUseCases
        
    }
    
    // MARK: - public methods
    
    
    /// Load initial page of podcasts
    func loadInitialPage() async {
        currentPage = 1
        pageNumber = 1
        currentDisplayIndex = 0
        hasNextPage = true
        displayedPodcasts.removeAll()
        allFetchedPodcasts.removeAll()
        await loadPage()
    }
    
    
    /// Loads the next page of podcasts.
    /// - Parameter currentItem: Podcast item
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
    
    // MARK: - private methods
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
