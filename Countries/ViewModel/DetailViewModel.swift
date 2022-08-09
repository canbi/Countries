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
    
    // Data
    let country: Country
    @Published var countryDetail: CountryDetail? = nil
    private var cancellables = Set<AnyCancellable>()
    
    init(country: Country){
        self.country = country
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
}
