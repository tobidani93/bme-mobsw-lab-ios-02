//
//  PlaceDetailView.swift
//  BestPlaces
//
//  Created by Daniel Tobias on 2026. 03. 08..
//

import SwiftUI

struct PlaceDetailView: View {
    
    var place: Place
    
    var body: some View {
        VStack{
            Text(place.icon)
                .font(.system(size: 120))
                .padding(.top, 30)
            Text(place.name)
                .font(.largeTitle)
                .padding()
            
            Text(place.description)
                .font(.body)
                .padding()
        }
    }
}
