//
//  HomeViewModel.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    // Service
    private var dataService: JSONDataService = JSONDataService()
    var cdDataService: CoreDataDataService
    
    // Data
    @Published var countries: Countries? = nil
    //@Published var favorites: [CDFavorites] = []
    private var cancellables = Set<AnyCancellable>()
    
    // Control
    @Published var loading: Bool = false
    @Published var selectedCountry: Country? = nil
    
    init(cdDataService: CoreDataDataService){
        self.cdDataService = cdDataService
        addSubscribers()
        self.dataService.getCountries()
        //self.favorites = cdDataService.favo
    }
}

// Setup Functions
extension HomeViewModel {
    func addSubscribers() {
        dataService.$countries
            .sink { [weak self] (returnedCountries) in
                self?.countries = self?.findFavorites(returnedCountries: returnedCountries)
            }
            .store(in: &cancellables)
        
        dataService.$loadingStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (returned) in
                self?.loading = returned
            }
            .store(in: &cancellables)
    }
    
    func findFavorites(returnedCountries: Countries?) -> Countries? {
        guard let returnedCountries = returnedCountries else { return nil }

        var countries: [Country] = []
        
        for country in returnedCountries.data {
            let tempCountry = Country(code: country.code,
                                      currencyCodes: country.currencyCodes,
                                      name: country.name,
                                      wikiDataID: country.wikiDataID,
                                      isFavorited: cdDataService.isFavorited(country.code))
            countries.append(tempCountry)
        }
        
        let tempCountries = Countries(data: countries,
                                      links: returnedCountries.links,
                                      metadata: returnedCountries.metadata)
        
        return tempCountries
    }
}

// Functions
extension HomeViewModel {
    func pageFunction(url: String){
        dataService.getCountiesByPage(url: url)
    }
    
    func makeFavorite(country: Country){
        if country.isFavorited {
            if let country = cdDataService.getCountry(country.code) {
                cdDataService.deleteCountry(country)
            }
        } else {
            let _ = cdDataService.saveCountry(country: country)
        }
        
        self.countries = findFavorites(returnedCountries: self.countries)
    }
}
