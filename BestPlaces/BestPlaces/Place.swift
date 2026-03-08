//
//  pLACE.swift
//  BestPlaces
//
//  Created by Daniel Tobias on 2026. 03. 08..
//

import Foundation

struct Place: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var icon: String
}
