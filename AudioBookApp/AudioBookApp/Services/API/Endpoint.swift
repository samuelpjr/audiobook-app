//
//  Endpoint.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//

import Foundation

protocol Endpoint {
    var url: URL? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var decoder: JSONDecoder { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum PodCastEndPoint {
    case podcastList
}

extension PodCastEndPoint: Endpoint {
    
    var method: HTTPMethod {
        switch self {
        case .podcastList: return .get
        }
    }
    
    private var baseURLString: String {
        return "https://listen-api-test.listennotes.com/api/v2"
    }
    
    private var path: String {
        switch self {
        case .podcastList: return "/best_podcasts"
        }
    }
    
    var url: URL? {
        URL(string: baseURLString + path)
    }
    
    var headers: [String: String]? {
        ["Accept": "application/json", "Content-Type": "application/json"]
    }
    
    var body: Data? {
        switch self {
        case .podcastList: return nil
        }
    }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
