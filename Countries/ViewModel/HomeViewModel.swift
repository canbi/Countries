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
    private var dataService: JSONDataService
    
    // Data
    @Published var countries: Countries? = nil
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: JSONDataService){
        self.dataService = dataService
        addSubscribers()
        self.dataService.getCountries()
    }
}

// Setup Functions
extension HomeViewModel {
    func addSubscribers() {
        dataService.$countries
            .sink { [weak self] (returnedCountries) in
                self?.countries = returnedCountries
            }
            .store(in: &cancellables)
    }
}
