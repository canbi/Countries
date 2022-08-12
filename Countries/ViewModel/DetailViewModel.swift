//
//  DetailViewModel.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import Combine
import SwiftUI

class DetailViewModel: ObservableObject {
    // Service
    private var dataService: JSONDataService = JSONDataService()
    private var cdDataService: CoreDataDataService
    
    // Data
    let country: Country
    @Published var countryDetail: CountryDetail? = nil
    private var cancellables = Set<AnyCancellable>()
    
    // Control
    @Published var isFavorited: Bool = false
    
    init(country: Country,cdDataService: CoreDataDataService){
        self.country = country
        self.isFavorited = country.isFavorited
        self.cdDataService = cdDataService
        addSubscribers()
        dataService.getCountryDetail(countryCode: country.code)
    }
}

// Setup Functions
extension DetailViewModel {
    func addSubscribers() {
        dataService.$countryDetail
            .sink { [weak self] (returnedDetail) in
                self?.countryDetail = returnedDetail
            }
            .store(in: &cancellables)
    }
    
    func makeFavorite(country: Country){
        if isFavorited {
            if let country = cdDataService.getCountry(country.code) {
                cdDataService.deleteCountry(country)
            }
        } else {
            let _ = cdDataService.saveCountry(country: country)
        }
        
        isFavorited.toggle()
    }
}
