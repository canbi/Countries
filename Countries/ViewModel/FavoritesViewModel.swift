//
//  FavoritesViewModel.swift
//  Countries
//
//  Created by Can Bi on 12.08.2022.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    // Service
    var cdDataService: CoreDataDataService
    
    // Data
    @Published var favorites: [CDFavorites] = []
    
    // Control
    @Published var selectedCountry: Country? = nil
    
    init(cdDataService: CoreDataDataService){
        self.cdDataService = cdDataService
        self.favorites = cdDataService.getFavorites()
    }
}

// Functions
extension FavoritesViewModel {
    func updateFavorites(){
        self.favorites = cdDataService.getFavorites()
    }
    
    func goDetailPage(country: CDFavorites){
        let tempCountry = Country(code: country.wrappedCode,
                                  currencyCodes: country.wrappedCurrencyCodes,
                                  name: country.wrappedName,
                                  wikiDataID: country.wrappedWikiDataID)
        
        self.selectedCountry = tempCountry
    }
    
    func deleteFavorite(country: CDFavorites){
        cdDataService.deleteCountry(country)
        updateFavorites()
    }
}
