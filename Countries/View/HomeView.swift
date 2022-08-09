//
//  HomeView.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm: HomeViewModel
    
    init(dataService: JSONDataService) {
        self._vm = StateObject(wrappedValue: HomeViewModel(dataService: dataService))
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataService: JSONDataService.previewInstance)
    }
}
