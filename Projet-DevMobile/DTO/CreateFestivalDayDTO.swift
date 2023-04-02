//
//  CreateFestivalDayDTO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 27/03/2023.
//

import Foundation
import SwiftUI
class CreateFestivalDayDTO:Decodable,Encodable{
    
    var nom:String
    var begining:String
    var ending:String
    
    init(nom: String, begining: String, ending: String) {
        self.nom = nom
        self.begining = begining
        self.ending = ending
    }
}

