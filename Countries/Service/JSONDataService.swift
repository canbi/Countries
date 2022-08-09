//
//  PhotoDataService.swift
//  MarsRoverPhotos
//
//  Created by Can Bi on 20.06.2022.
//

import SwiftUI
import Combine

class JSONDataService: ObservableObject {
    static var previewInstance = JSONDataService()
    let decoder = JSONDecoder()
    
    //Data
    @Published var countries: Countries? = nil
    @Published var countryDetail: CountryDetail? = nil
    var countriesSubscription: AnyCancellable?
    var countryDetailSubscription: AnyCancellable?
    
    //Control
    @Published var loadingStatus: Bool = false
    
    init() {
    }
}

// MARK: - Functions
extension JSONDataService {
    func getCountries(limit: Int = 10) {
        let endpoint = Endpoint.getCountries(limit: limit)
        guard let url = endpoint.url else { return }
        
        countriesSubscription = NetworkingManager.download(url: url,
                                                           loadingStatus: Binding(get: { self.loadingStatus },
                                                                                  set: { self.loadingStatus = $0 }))
            .decode(type: Countries.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCountries) in
                guard let self = self else { return }
                self.loadingStatus = false
                self.countries = returnedCountries
                self.countriesSubscription?.cancel()
            })
    }
    
    func getCountryDetail(countryCode: String) {
        let endpoint = Endpoint.getCountry(countryCode: countryCode)
        guard let url = endpoint.url else { return }
        
        countryDetailSubscription = NetworkingManager.download(url: url,
                                                               loadingStatus: Binding(get: { self.loadingStatus },
                                                                                      set: { self.loadingStatus = $0 }))
            .decode(type: CountryDetail.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedDetail) in
                guard let self = self else { return }
                self.loadingStatus = false
                self.countryDetail = returnedDetail
                self.countryDetailSubscription?.cancel()
            })
    }
    
    func getCountiesByPage(url: String) {
        let endpoint = Endpoint.getCountriesPage(url: url)
        guard let url = endpoint.url else { return }
        
        countriesSubscription = NetworkingManager.download(url: url,
                                                           loadingStatus: Binding(get: { self.loadingStatus },
                                                                                  set: { self.loadingStatus = $0 }))
            .decode(type: Countries.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCountries) in
                guard let self = self else { return }
                self.loadingStatus = false
                self.countries = returnedCountries
                self.countriesSubscription?.cancel()
            })
    }
}
