//
//  ZoneModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI

class ZoneModel:ObservableObject,Identifiable,Hashable{
    
    
    // Cette fonction est nécessaire pour rendre le modèle conforme à Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        // Cette fonction est également nécessaire pour rendre le modèle conforme à Hashable
        static func == (lhs: ZoneModel, rhs: ZoneModel) -> Bool {
            lhs.id == rhs.id
        }
    
    @Published public var id:String
    @Published public var nom:String
    @Published public var nbrvol:Int
    
    init(id:String, nom: String, nbrvol: Int) {
        
        self.id = id
        self.nom = nom
        self.nbrvol = nbrvol
    }
   
}
