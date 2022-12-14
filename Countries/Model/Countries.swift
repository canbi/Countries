//
//  Countries.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import Foundation

// MARK: - Countries
struct Countries: Codable {
    let data: [Country]
    let links: [Link]
    let metadata: Metadata
    
    var prevLink: String? { links.first(where: { $0.rel == "prev"})?.href }
    var nextLink: String? { links.first(where: { $0.rel == "next"})?.href }
    var currentMaxOffset: Int {
        var tempMaxOffset = metadata.currentOffset + 10
        if tempMaxOffset > metadata.totalCount {
            tempMaxOffset = metadata.totalCount
        }
        
        return tempMaxOffset
    }
}

// MARK: - Country
struct Country: Codable, Identifiable {
    let code: String
    let currencyCodes: [String]
    let name, wikiDataID: String
    var isFavorited: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case code, currencyCodes, name
        case wikiDataID = "wikiDataId"
    }
    
    var id: String { wikiDataID }
    
    static var previewData: Country {
        return .init(code: "TR",
                     currencyCodes: ["Turkish Lira"],
                     name: "Türkiye",
                     wikiDataID: "Q30")
    }
}

// MARK: - Link
struct Link: Codable {
    let rel, href: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let currentOffset, totalCount: Int
}
