//
//  CDFavorites+CoreDataProperties.swift
//  Countries
//
//  Created by Can Bi on 12.08.2022.
//
//

import Foundation
import CoreData


extension CDFavorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavorites> {
        return NSFetchRequest<CDFavorites>(entityName: "CDFavorites")
    }

    @NSManaged public var addFavoritesDate: Date?
    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var wikiDataID: String?
    @NSManaged public var currencyCodes: [String]?

    var wrappedCode: String { code ?? UUID().uuidString }
    var wrappedName: String { name ?? "error" }
    var wrappedWikiDataID: String { wikiDataID ?? "error" }
    var wrappedCurrencyCodes: [String] { currencyCodes ?? ["error"] }
}

extension CDFavorites : Identifiable {

}
