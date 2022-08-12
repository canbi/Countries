//
//  FavoritesView.swift
//  Countries
//
//  Created by Can Bi on 12.08.2022.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var vm: FavoritesViewModel
    @Binding var shouldScrollToTop: Bool
    
    init(cdDataService: CoreDataDataService, shouldScrollToTop: Binding<Bool>){
        self._vm = StateObject(wrappedValue: FavoritesViewModel(cdDataService: cdDataService))
        self._shouldScrollToTop = shouldScrollToTop
    }
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView {
                LazyVStack(spacing: 6, pinnedViews: .sectionHeaders) {
                    MainSection
                }
            }
            .navigationDestination(for: $vm.selectedCountry) { country in
                DetailView(country: country, cdDataService: vm.cdDataService)
            }
        }
        .onAppear{ vm.updateFavorites()}
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(cdDataService: CoreDataDataService(moc: CoreDataController.moc),
                      shouldScrollToTop: .constant(false))
    }
}


// Section
extension FavoritesView {
    private var MainSection: some View {
        Section(header: SectionHeader) {
            LazyVGrid(columns: [GridItem(.flexible(maximum: .infinity))],
                      alignment: .leading,
                      spacing: 10) {
                
                
                ForEach(vm.favorites, id: \.wrappedCode) { country in
                    CountryButton(country: country)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var SectionHeader: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("Favorites")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
            
            Text("Total favorites: \(vm.favorites.count)")
            Spacer()
        }
        .foregroundColor(.red.opacity(0.6))
        .padding(.top, 44)
        .padding(.bottom, 8)
    }
}



// Buttons
extension FavoritesView {
    private func CountryButton(country: CDFavorites) -> some View {
        CountryRow(action: {
            vm.goDetailPage(country: country)
        }, favoriteAction: {
            vm.deleteFavorite(country: country)
        }, color: .red.opacity(0.2),
        countryName: country.wrappedName,
                   isFavorited: true)
    }
}
