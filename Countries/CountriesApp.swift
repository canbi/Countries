//
//  CountriesApp.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import SwiftUI

@main
struct CountriesApp: App {
    let dataService: JSONDataService = JSONDataService()
    
    var body: some Scene {
        WindowGroup {
            HomeView(dataService: dataService)
        }
    }
}
