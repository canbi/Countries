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
    
    // Control
    @State private var tabSelection: NavBarItem = .home
    @State var shouldScrollToTop: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrollView {
                    TabView(selection: $tabSelection) {
                        HomeView(dataService: dataService)
                            .tag(NavBarItem.home)
                        
                        HomeView(dataService: dataService)
                            .tag(NavBarItem.home)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
                }
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .overlay(alignment: .bottom) {
                    CustomTabBarView(tabs: [.home, .saved],
                                     selection: $tabSelection,
                                     localSelection: .home, scrollToTop: $shouldScrollToTop)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
