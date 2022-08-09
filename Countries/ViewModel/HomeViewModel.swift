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
    private var dataService: JSONDataService!
    
    // Data
    @Published var countries: Countries? = nil
    private var cancellables = Set<AnyCancellable>()
    
    // Control
    @Published var loading: Bool = false
    @Published var selectedCountry: Country? = nil
    
    init(){
    }
}

// Setup Functions
extension HomeViewModel {
    func setup(dataService: JSONDataService){
        self.dataService = dataService
        addSubscribers()
        self.dataService.getCountries()
    }
    
    func addSubscribers() {
        dataService.$countries
            .sink { [weak self] (returnedCountries) in
                self?.countries = returnedCountries
            }
            .store(in: &cancellables)
        
        dataService.$loadingStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (returned) in
                self?.loading = returned
            }
            .store(in: &cancellables)
    }
}

extension HomeViewModel {
    func pageFunction(url: String){
        dataService.getCountiesByPage(url: url)
    }
}
