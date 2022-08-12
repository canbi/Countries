//
//  DetailView.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var dataService: JSONDataService
    @StateObject var vm: DetailViewModel
    
    init(country: Country){
        self._vm = StateObject(wrappedValue: DetailViewModel(country: country))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CountryImageView

            InformationView
            
            InfoButton
            
            Spacer()
        }
        .navigationTitle(vm.country.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //TODO
                } label: {
                    Image(systemName: "heart")
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(country: Country.previewData)
        }
    }
}

extension DetailView {
    private var CountryImageView: some View {
        Group {
            if let detail = vm.countryDetail {
                ImageView(photo: detail.data.flagImageURI, id: detail.data.wikiDataID)
            } else {
                ProgressView()
                    .frame(maxHeight: 275, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .frame(maxHeight: 275, alignment: .top)
    }
    
    private var InformationView: some View {
        Group {
            Text(vm.country.name)
                .font(.largeTitle)
            
            Text("Country Code: ") .fontWeight(.bold) + Text(vm.country.code)
            Text("Currency: ") .fontWeight(.bold) + Text(ListFormatter.localizedString(byJoining: vm.country.currencyCodes))
            
            if let detail = vm.countryDetail {
                Text("Dialing Code: ") .fontWeight(.bold) + Text(detail.data.callingCode)
                Text("Capital: ") .fontWeight(.bold) + Text(detail.data.capital)
                Text("Number of Regions: ") .fontWeight(.bold) + Text(String(detail.data.numRegions))
            }
            
            
        }
        .padding(.horizontal)
    }
    
    private var InfoButton: some View {
        Button(action: {
            openURL(URL(string: "https://www.wikidata.org/wiki/\(vm.country.wikiDataID)")!)
        }, label: {
            HStack {
                Text("For more information")
                Image(systemName: "chevron.right")
            }
            .padding(.horizontal)
            .padding(.vertical,8)
            .background(RoundedRectangle(cornerRadius: 12).fill(.blue))
        })
        .tint(.white)
    }
}
