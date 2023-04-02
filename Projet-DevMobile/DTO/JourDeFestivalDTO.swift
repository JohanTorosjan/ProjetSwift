//
//  JourDeFestivalDTO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI


class JourDeFestivalDTO:Decodable,Encodable{
    
    var _id:String
    var nom:String
    var begining:String
    var ending:String
   // var creneaux:[EventsDTO]
    
    init(_id: String, nom: String, begining: String, ending: String) {
        self._id = _id
        self.nom = nom
        self.begining = begining
        self.ending = ending
        //self.creneaux = creneaux
    }
    
}
