//
//  ContentView.swift
//  BestPlaces
//
//  Created by Daniel Tobias on 2026. 03. 05..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            PlacesListView().tabItem {
                Image(systemName: "map.fill")
                Text("Helyek")
                //Label("Tab 1", systemImage: "map.fill")
            }
            NavigationStack{
                ProfileView()
            }.tabItem {
                Image(systemName: "person.fill")
                Text("Profil")
                //Label("Profil", systemImage: "person.fill")
            }
            
        }
    }
}

#Preview {
    ContentView()
}
