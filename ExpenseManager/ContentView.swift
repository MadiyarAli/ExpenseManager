//
//  ContentView.swift
//  ExpenseManager
//
//  Created by Madiyar Ali on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: Tab = .recents
    var body: some View{
        TabView(selection: $activeTab) {
            Recents()
                .tag(Tab.recents)
                .tabItem { Tab.recents.tabContent }
            
            Graphs()
                .tag(Tab.charts)
                .tabItem { Tab.charts.tabContent }
            
        }
        .tint(appTint)
    }
}

#Preview {
    ContentView()
}
