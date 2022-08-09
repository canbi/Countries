//
//  HomeView.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import AlertToast
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataService: JSONDataService
    @StateObject var vm: HomeViewModel
    @Binding var shouldScrollToTop: Bool
    
    init(shouldScrollToTop: Binding<Bool>) {
        self._vm = StateObject(wrappedValue: HomeViewModel())
        self._shouldScrollToTop = shouldScrollToTop
    }
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView {
                LazyVStack(spacing: 6, pinnedViews: .sectionHeaders) {
                    MainSection
                        .sheet(item: $vm.selectedCountry) {
                            vm.selectedCountry = nil
                        } content: { country in
                            DetailView(country: country)
                        }

                }
            }.toast(isPresenting: $vm.loading) {
                AlertToast(type: .loading, title: "Loading", subTitle: "API limit")
            }
            .onAppear {
                vm.setup(dataService: dataService)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(shouldScrollToTop: .constant(false))
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
        Button(action: {
            vm.selectedCountry = country
        }) {
            HStack {
                Text(country.name)
                Spacer()
                Image(systemName: "heart")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.secondary, lineWidth: 2)
            )
        }
        .tint(.primary)
        .contentShape(Rectangle())
    }
}

// Section Header and Footer
extension HomeView {
    private var SectionHeader: some View {
        HStack {
            Text("Countries")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
            if let countries = vm.countries {
                Text("\(countries.metadata.currentOffset + 1)-\(countries.currentMaxOffset)")
            }
            Spacer()
        }
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
                    }, color: Color.secondary)
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
                    }, color: Color.secondary)
                }
            }
            
        }
        .padding(.vertical)
        .padding(.horizontal)
    }
}
