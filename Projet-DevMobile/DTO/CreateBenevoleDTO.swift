//
//  CreateBenevoleDTO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 02/04/2023.
//

import Foundation
class CreateBenevoleDTO:Decodable,Encodable{
   
    var prenom:String
    var nom:String
    var email:String
    var password: String

    init(prenom: String, nom: String, email: String,password: String) {
        self.prenom = prenom
        self.nom = nom
        self.email = email
        self.password = password
    }
}

