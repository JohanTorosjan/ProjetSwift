//
//  GameDTO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 13/03/2023.
//

import Foundation

 class GameDTO:Decodable{
     var _id: String
     var nom:String
     var type:String
     
     init(_id: String,nom: String, type: String) {
         self._id = _id
         self.nom = nom
         self.type = type
     }
 }
 
