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
    private var dataService: JSONDataService!
    
    // Data
    let code: String
    @Published var countryDetail: CountryDetail? = nil
    private var cancellables = Set<AnyCancellable>()
    
    init(code: String){
        self.code = code
    }
}

// Setup Functions
extension DetailViewModel {
    func setup(dataService: JSONDataService){
        self.dataService = dataService
        addSubscribers()
        dataService.getCountryDetail(countryCode: code)
    }
    
    func addSubscribers() {
        dataService.$countryDetail
            .sink { [weak self] (returnedDetail) in
                self?.countryDetail = returnedDetail
            }
            .store(in: &cancellables)
    }
}
