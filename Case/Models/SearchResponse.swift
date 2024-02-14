//
//  SearchResponse.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import Foundation

// MARK: - SearchResponse

struct SearchResponse: Decodable {
    let movies: [Movie]
    let totalResults: String
    let response: String

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
}
