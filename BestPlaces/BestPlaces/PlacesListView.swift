//
//  PlacesListView.swift
//  BestPlaces
//
//  Created by Daniel Tobias on 2026. 03. 08..
//

import UIKit
import SwiftUI

struct PlacesListView: View {
    
    @State private var places: [Place] = [
        Place(name: "Eiffel-torony", description: "Párizs ikonikus tornya.", icon: "🗼"),
        Place(name: "Szabadság-szobor", description: "Neoklasszicista szobor New York kikötőjében.", icon: "🗽"),
        Place(name: "Kolosszeum", description: "Ovális amfiteátrum Róma központjában.", icon: "🏛️")
    ]
    
    @State var showingAddPlaceSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List(places) { place in
                NavigationLink(value: place) {
                    HStack {
                        Text(place.icon).font(.title)
                        Text(place.name).font(.headline).foregroundColor(.primary)
                    }.padding(.vertical, 4)
                }
            }
            .navigationTitle("Kedvenc Helyeim")
            .navigationDestination(for: Place.self){place in
                PlaceDetailView(place: place)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddPlaceSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPlaceSheet) {
                AddPlaceView(places: $places)
            }
        }
    }
    
    
}
