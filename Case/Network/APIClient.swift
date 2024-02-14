//
//  APIClient.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import Foundation
import Alamofire

struct APIClient {
    
    static func searchMovies(_ searchTerm: String, completion: @escaping (Result<SearchResponse, AFError>) -> Void) {
        AF.request(APIRouter.searchMovies(searchTerm)).validate(statusCode: 200..<300).responseDecodable(of: SearchResponse.self) { response in
            completion(response.result)
        }
    }
    
    static func getMovieDetails(_ imdbID: String, completion: @escaping (Result<MovieDetails, AFError>) -> Void) {
        AF.request(APIRouter.getMovieDetails(imdbID)).validate(statusCode: 200..<300).responseDecodable(of: MovieDetails.self) { response in
            completion(response.result)
        }
    }
}
