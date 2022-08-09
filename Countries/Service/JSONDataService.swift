//
//  PhotoDataService.swift
//  MarsRoverPhotos
//
//  Created by Can Bi on 20.06.2022.
//

import Foundation
import Combine

class JSONDataService: ObservableObject {
    static var previewInstance = JSONDataService()
    let decoder = JSONDecoder()
    
    @Published var countries: Countries? = nil
    @Published var countryDetail: CountryDetail? = nil
    
    init() { }
    
    var countriesSubscription: AnyCancellable?
    var countryDetailSubscription: AnyCancellable?
}

// MARK: - Functions
extension JSONDataService {
    func getCountries(limit: Int = 10) {
        let endpoint = Endpoint.getCountries(limit: limit)
        guard let url = endpoint.url else { return }
        
        countriesSubscription = NetworkingManager.download(url: url)
            .decode(type: Countries.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCountries) in
                guard let self = self else { return }
                self.countries = returnedCountries
                self.countriesSubscription?.cancel()
            })
    }
    
    func getCountryDetail(countryCode: String) {
        let endpoint = Endpoint.getCountry(countryCode: countryCode)
        guard let url = endpoint.url else { return }
        
        countryDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CountryDetail.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedDetail) in
                guard let self = self else { return }
                self.countryDetail = returnedDetail
                self.countryDetailSubscription?.cancel()
            })
    }
}
