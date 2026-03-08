//
//  CitySearchView.swift
//  MyWeather
//
//  Created by Daniel Tobias on 2026. 03. 08..
//
import SwiftUI

struct CitySearchView: View {
    @Binding var currentCity: String
    
    var weatherService: WeatherService
    
    @State var searchText: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Keress egy városra")) {
                    TextField("Város neve (pl. London)", text: $searchText)
                        .submitLabel(.search)
                        .onSubmit {
                            performSearch()
                        }
                }
                
                Button(action: {
                    performSearch()
                }) {
                    Text("Keresés")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .disabled(searchText.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .navigationTitle("Keresés")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Mégse") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    
    private func performSearch(){
        guard !searchText.isEmpty else { return }
        
        currentCity = searchText
        
        Task {
            await weatherService.fetchWeather(for: currentCity)
            dismiss()
        }
    }
}

#Preview {

    CitySearchView(currentCity: .constant("Budapest"), weatherService: WeatherService())
}
