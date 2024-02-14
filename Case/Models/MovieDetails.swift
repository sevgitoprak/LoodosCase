//
//  MovieDetails.swift
//  Case
//
//  Created by Sevgi Toprak on 12.02.2024.
//

import Foundation

// MARK: - MovieDetails
struct MovieDetails: Codable {
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    let ratings: [Rating]
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let type: String
    let response: String
    
    var posterURL: URL? {
        return URL(string: poster)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case response = "Response"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let source: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
