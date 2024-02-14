//
//  AnalyticsManager.swift
//  Case
//
//  Created by Sevgi Toprak on 13.02.2024.
//

import Foundation
import FirebaseAnalytics

final class AnalyticsManager {
    static let shared = AnalyticsManager()
    
    private init() {}
    
    func logMovieSelected(movieId: String, movieTitle: String) {
        Analytics.logEvent("movie_selected", parameters: [
            "movie_id": movieId,
            "movie_title": movieTitle
        ])
        
        print("Movie Selected Log: \(movieId) \(movieTitle)")
    }
    
    func logMovieSearch(query: String, numberOfResults: Int) {
        Analytics.logEvent("movie_search", parameters: [
            "search_query": query,
            "number_of_results": numberOfResults
        ])
        
        print("Movie Searched Log: \(query) \(numberOfResults)")
    }
}

