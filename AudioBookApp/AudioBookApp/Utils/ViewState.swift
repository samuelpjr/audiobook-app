//
//  ViewState.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//


import Foundation

enum ViewState: Equatable {
    case loading
    case loaded
    case error(String)
    case idle
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var content: Bool {
        if case .loaded = self {
            return true
        }
        return false
    }

    var errorMessage: String? {
        if case let .error(message) = self {
            return message
        }
        return nil
    }
}
