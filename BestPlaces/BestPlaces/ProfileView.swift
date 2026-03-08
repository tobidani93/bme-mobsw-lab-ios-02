//
//  ProfileView.swift
//  BestPlaces
//
//  Created by Daniel Tobias on 2026. 03. 08..
//
import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack(spacing: 10){
            Image(systemName: "person.crop.circle.fill").resizable().frame(width: 100, height: 100).foregroundColor(.blue)
            Text("Daniel Tobias").font(.largeTitle).fontWeight(.bold)
            Text("User").font(.title3)
        }.navigationTitle(Text("Profil"))
    }
}
