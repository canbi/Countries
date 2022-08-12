//
//  HomeView.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import AlertToast
import SwiftUI

struct HomeView: View {
    @StateObject var vm: HomeViewModel
    @Binding var shouldScrollToTop: Bool
    
    init(cdDataService: CoreDataDataService, shouldScrollToTop: Binding<Bool>) {
        self._vm = StateObject(wrappedValue: HomeViewModel(cdDataService: cdDataService))
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
            .toast(isPresenting: $vm.loading) {
                AlertToast(type: .loading, title: "Loading", subTitle: "API limit")
            }
        }
        .onAppear{
            vm.countries = vm.findFavorites(returnedCountries: vm.countries)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(cdDataService: CoreDataDataService(moc: CoreDataController.moc),
                 shouldScrollToTop: .constant(false))
    }
}

// Section
extension HomeView {
    private var MainSection: some View {
        Section(header: SectionHeader, footer: SectionFooter) {
            LazyVGrid(columns: [GridItem(.flexible(maximum: .infinity))],
                      alignment: .leading,
                      spacing: 10) {
                if let countries = vm.countries?.data {
                    ForEach(countries, id: \.code) { country in
                        CountryButton(country: country)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// Buttons
extension HomeView {
    private func CountryButton(country: Country) -> some View {
        CountryRow(action: {
            vm.selectedCountry = country
        }, favoriteAction: {
            vm.makeFavorite(country: country)
        }, color: .blue.opacity(0.2),
                   countryName: country.name,
                   isFavorited: country.isFavorited)
    }
}

// Section Header and Footer
extension HomeView {
    private var SectionHeader: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("Countries")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
            if let countries = vm.countries {
                Text("\(countries.metadata.currentOffset + 1)-\(countries.currentMaxOffset)")
            }
            Spacer()
        }
        .foregroundColor(.blue.opacity(0.6))
        .padding(.top, 44)
        .padding(.bottom, 8)
    }
    
    private var SectionFooter: some View {
        HStack {
            if let countries = vm.countries {
                if let prevHref = countries.prevLink {
                    FullWidthButton(content: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Prev")
                            Spacer()
                        }
                    }, action: {
                        vm.pageFunction(url: prevHref)
                    }, color: .blue.opacity(0.2))
                }
                
                if let nextHref = countries.nextLink {
                    FullWidthButton(content: {
                        HStack {
                            Spacer()
                            Text("Next")
                            Image(systemName: "chevron.right")
                        }
                    }, action: {
                        vm.pageFunction(url: nextHref)
                    }, color: .blue.opacity(0.2))
                }
            } 
        }
        .padding(.vertical)
        .padding(.horizontal)
    }
}
