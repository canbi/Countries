//
//  DetailView.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataService: JSONDataService
    
    @StateObject var vm: DetailViewModel
    
    init(country: Country){
        self._vm = StateObject(wrappedValue: DetailViewModel(code: country.code))
    }
    
    var body: some View {
        VStack{
            if let detail = vm.countryDetail {
                ImageView(photo: detail.data.flagImageURI, id: detail.data.wikiDataID)
                    .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            vm.setup(dataService: dataService)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(country: Country.previewData)
    }
}
