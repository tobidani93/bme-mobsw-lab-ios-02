//
//  AddPlaceView.swift
//  BestPlaces
//
//  Created by Daniel Tobias on 2026. 03. 08..
//
import SwiftUI

struct AddPlaceView: View {
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var icon: String = ""
    
    @Binding var places: [Place]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Hely adatai")) {
                    TextField("Hely neve", text: $name)
                    TextField("Leírás", text: $description)
                    TextField("Ikon (emoji)", text: $icon)
                }
            }.navigationBarItems(
                leading: Button("Mégse") {
                    dismiss()
                },
                trailing: Button("Mentés") {
                    let newPlace = Place(name: name, description: description, icon: icon)
                    places.append(newPlace)
                    dismiss()
                }.onSubmit{ dismiss() }
            )
        }
    }
}
#Preview {
    AddPlaceView(places: .constant([]))
}
