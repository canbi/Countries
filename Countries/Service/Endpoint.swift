//
//  Endpoint.swift
//  MarsRoverPhotos
//
//  Created by Can Bi on 22.06.2022.
//

import Foundation

struct Endpoint {
    let path: String
    var queryItems: [URLQueryItem]
    
    static let apiKey = "cd05a7537amshf6fb857dba9a6c5p117922jsn5a4171625ec4"
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "wft-geo-db.p.rapidapi.com"
        components.path = path
        if queryItems.count > 0 {
            components.queryItems = queryItems
        }
        
        return components.url
    }
}

// MARK: - Functions
extension Endpoint {
    static func getCountries(limit: Int) -> Endpoint {
        Endpoint(
            path: "/v1/geo/countries",
            queryItems: [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "rapidapi-key", value: apiKey)
            ]
        )
    }
    
    static func getCountry(countryCode: String) -> Endpoint {
        Endpoint(
            path: "/v1/geo/countries/\(countryCode)",
            queryItems: [
                URLQueryItem(name: "rapidapi-key", value: apiKey)
            ]
        )
    }
    
    static func getCountriesPage(url: String) -> Endpoint {
        let urlParts = url.components(separatedBy: "?")
        let path = urlParts[0]
        let queries = urlParts[1].components(separatedBy: "&")
        
        var queryItems: [URLQueryItem] = []
        
        for query in queries {
            let parts = query.components(separatedBy: "=")
            queryItems.append(URLQueryItem(name: parts[0], value: parts[1]))
        }
        
        return Endpoint(
            path: path,
            queryItems: queryItems
        )
    }
}
