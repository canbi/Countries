//
//  CoreDataService.swift
//  MarsRoverPhotos
//
//  Created by Can Bi on 25.06.2022.
//


import SwiftUI
import CoreData

class CoreDataDataService: ObservableObject {
    var moc: NSManagedObjectContext
    private var favorites: [CDFavorites]
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
        
        let fetchRequest: NSFetchRequest<CDFavorites> = CDFavorites.fetchRequest()
        
        do {
            self.favorites = try self.moc.fetch(fetchRequest) as [CDFavorites]
        } catch let error {
            print("error FetchRequest \(error)")
            self.favorites = []
        }
    }
    
    func saveMOC() {
        if self.moc.hasChanges {
            try? self.moc.save()
            
            favorites = getFavorites()
        }
    }
}

// MARK: - Functions
extension CoreDataDataService {
    func getFavorites() -> [CDFavorites] {
        let fetchRequest: NSFetchRequest<CDFavorites> = CDFavorites.fetchRequest()
        
        var returnedCountries: [CDFavorites] = []
        
        do {
            returnedCountries = try self.moc.fetch(fetchRequest) as [CDFavorites]
        } catch let error {
            print("error FetchRequest \(error)")
            returnedCountries = []
        }
        
        return returnedCountries
    }
    
    func saveCountry(country: Country) -> CDFavorites {
        let newCountry = CDFavorites(context: self.moc)
        newCountry.addFavoritesDate = .now
        newCountry.code = country.code
        newCountry.name = country.name
        
        saveMOC()
        print("saved in coredata")
        return newCountry
    }
    
    func deleteCountry(_ country: CDFavorites){
        self.moc.delete(country)
        print("remove from coredata")
        saveMOC()
    }
    
    func getCountry(_ wrappedCode: String) -> CDFavorites? {
        favorites.first(where: { $0.wrappedCode == wrappedCode })
    }
    
    func isFavorited(_ wrappedCode: String) -> Bool {
        return getCountry(wrappedCode) != nil
    }
}
