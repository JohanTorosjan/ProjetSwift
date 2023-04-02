//
//  BenevolesDTO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 16/03/2023.
//

import Foundation
import SwiftUI
 class BenevolesDTO:Decodable,Encodable{
     var _id: String
     var prenom:String
     var nom:String
     var email:String

     init(_id: String, prenom: String, nom: String, email: String) {
         self._id = _id
         self.prenom = prenom
         self.nom = nom
         self.email = email
     }
 }
 
