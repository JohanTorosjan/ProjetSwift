//
//  BenevoleModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 16/03/2023.
//

import Foundation
import SwiftUI

class BenevoleModel:ObservableObject,Identifiable{
    @Published public var id:String
    @Published public var prenom:String
    @Published public var nom:String
    @Published public var email:String
    @Published public var creneaux:[CreneauxModel]=[]
    
    @Published var uiState:BenevoleStates = .Init{
        didSet{
            switch uiState{
            case .Register(let creneaux):
                self.creneaux.append(creneaux)
            case .Create(let benevole):
                self.id = benevole.id
                self.prenom = benevole.prenom
                self.email = benevole.email
                self.nom = benevole.nom
            default:break
            }
        }
    }
    init(id:String,prenom: String, nom: String, email: String) {
        self.id=id
        self.prenom = prenom
        self.nom = nom
        self.email = email
    }
    

}

enum BenevoleStates{
    case Init
    case Register(CreneauxModel)
    case Create(BenevoleModel)
    case Error
}
