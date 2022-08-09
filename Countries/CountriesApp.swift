//
//  CountriesApp.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import SwiftUI

@main
struct CountriesApp: App {
    @StateObject private var dataService = JSONDataService()
    
    // Control
    @State private var tabSelection: NavBarItem = .home
    @State var shouldScrollToTop: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrollView {
                    tabView
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
            .environmentObject(dataService)
        }
    }
}

extension CountriesApp {
    private var tabView: some View {
        TabView(selection: $tabSelection) {
            HomeView(shouldScrollToTop: $shouldScrollToTop)
                .tag(NavBarItem.home)
            
            HomeView(shouldScrollToTop: $shouldScrollToTop)
                .tag(NavBarItem.saved)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)
    }
}
