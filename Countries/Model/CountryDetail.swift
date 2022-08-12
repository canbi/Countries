//
//  CountryDetail.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import Foundation

// MARK: - CountryDetail
struct CountryDetail: Codable {
    let data: Detail
}

// MARK: - Detail
struct Detail: Codable {
    let capital: String?
    let code, callingCode: String
    let currencyCodes: [String]
    let flagImageURI: String
    let name: String
    let numRegions: Int
    let wikiDataID: String
    
    enum CodingKeys: String, CodingKey {
        case capital, code, callingCode, currencyCodes
        case flagImageURI = "flagImageUri"
        case name, numRegions
        case wikiDataID = "wikiDataId"
    }
}
