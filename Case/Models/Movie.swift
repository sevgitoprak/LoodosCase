//
//  Movie.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import Foundation
import IGListKit

// MARK: - Movie

class Movie: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    var details: MovieDetails?
    
    var posterURL: URL? {
        return URL(string: poster)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

extension Movie: Equatable {
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        if lhs.imdbID == rhs.imdbID && lhs.title == rhs.title && lhs.year == rhs.year {
            return true
        }
        return false
    }
}

extension Movie: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return imdbID as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Movie else { return false }
        return self == object
    }
}
