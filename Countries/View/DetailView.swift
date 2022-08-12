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
    
    let imageHeightLimit: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 600 : 275
    
    init(country: Country, cdDataService: CoreDataDataService){
        self._vm = StateObject(wrappedValue: DetailViewModel(country: country, cdDataService: cdDataService))
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
                    vm.makeFavorite(country: vm.country)
                } label: {
                    Image(systemName: vm.isFavorited ? "heart.fill" : "heart")
                        .foregroundColor(vm.isFavorited ? .red : .primary)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(country: Country.previewData,
                       cdDataService: CoreDataDataService(moc: CoreDataController.moc))
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
                    .frame(maxHeight: imageHeightLimit, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .frame(maxHeight: imageHeightLimit, alignment: .top)
    }
    
    private var InformationView: some View {
        Group {
            Text(vm.country.name)
                .font(.largeTitle)
            
            Text("Country Code: ") .fontWeight(.bold) + Text(vm.country.code)
            Text("Currency: ") .fontWeight(.bold) + Text(ListFormatter.localizedString(byJoining: vm.country.currencyCodes))
            
            if let detail = vm.countryDetail {
                Text("Dialing Code: ") .fontWeight(.bold) + Text(detail.data.callingCode)
                Text("Capital: ") .fontWeight(.bold) + Text(detail.data.capital ?? "N/A")
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
        .padding(.leading)
    }
}
