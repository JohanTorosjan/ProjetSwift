//
//  JourDeFestivalModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI

class JourDeFestivalModel:ObservableObject,Identifiable{
    
    @Published public var id:String
    @Published public var nom:String
    @Published public var beginingdate:Date
    @Published public var endingdate:Date
    @Published public var creneaux:[CreneauxModel]
    
    init(id:String, nom: String, beginingdate: Date, endingdate: Date, creneaux: [CreneauxModel]) {
        self.id=id
        self.nom = nom
        self.beginingdate = beginingdate
        self.endingdate = endingdate
        self.creneaux = creneaux
    }
    
}
