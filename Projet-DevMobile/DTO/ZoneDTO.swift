//
//  ZoneDTO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI

class ZoneDTO:Decodable,Encodable{
    var _id:String
    var nom:String
    var nombreBenevolesNecessaire:Int
    
    
    init(_id:String, nom: String, nombreBenevolesNecessaire: Int) {
        self._id = _id
        self.nom = nom
        self.nombreBenevolesNecessaire = nombreBenevolesNecessaire
    }
    
}
