//
//  CreateFestivalDTO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 26/03/2023.
//


import Foundation
import SwiftUI
class CreateFestivalDTO:Decodable,Encodable{
    
    var nom:String
    var annee:Int
    
    init(nom: String, annee: Int) {
        self.nom = nom
        self.annee = annee
    }
}

