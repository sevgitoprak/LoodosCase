//
//  APIRouter.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case searchMovies(String)
    case getMovieDetails(String)
    
    private var baseURL: String {
        return "http://www.omdbapi.com/"
    }
    
    private var apiKey: String {
        return "dd0217c6"
    }
    
    var path: String {
        switch self {
        case .searchMovies(let searchTerm):
            return ""
        case .getMovieDetails(let rate):
            return ""
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryParams: [URLQueryItem]? {
        switch self {
        case .searchMovies(let searchTerm):
            return [
                URLQueryItem(name: "apikey", value: apiKey),
                URLQueryItem(name: "s", value: searchTerm)
            ]
        case .getMovieDetails(let imdbID):
            return [
                URLQueryItem(name: "apikey", value: apiKey),
                URLQueryItem(name: "i", value: imdbID)
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let fullPath = baseURL
        guard var urlComponents = URLComponents(string: fullPath) else {
            throw AFError.invalidURL(url: fullPath)
        }
        
        if let queryParams = queryParams {
            urlComponents.queryItems = queryParams
        }
        
        guard let url = urlComponents.url else {
            throw AFError.invalidURL(url: fullPath)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
