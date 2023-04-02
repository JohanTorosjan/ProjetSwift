//
//  FestivalListDTO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI
class FestivalListDTO:Decodable{
    
    var _id:String
    var nom:String
    var annee:String
    var jours:[JourDeFestivalDTO]
    
    init(_id: String, nom: String, annee: String, jours:[JourDeFestivalDTO]) {
        self._id = _id
        self.nom = nom
        self.annee = annee
        self.jours=jours
    }
    

    
}
