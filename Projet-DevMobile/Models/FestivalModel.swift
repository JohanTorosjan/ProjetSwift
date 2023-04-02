//
//  FestivalModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI

class FestivalModel:ObservableObject,Identifiable{
    @Published public var id:String
    @Published public var nom:String
    @Published public var annee:Int
    @Published public var jourDeFestival:[JourDeFestivalModel]
    @Published public var zone:[ZoneModel]
    
    
    
    @Published var uiState:FestivalStates = .Init{
        didSet{
            switch uiState{
            case .Update(let nom,let annee):
                self.nom=nom
                self.annee=annee
            default:break
                
            }
        }
    }
    
    init(id:String, nom: String, annee: Int, jourDeFestival: [JourDeFestivalModel], zone:[ZoneModel]) {
        self.id = id
        self.nom = nom
        self.annee = annee
        self.jourDeFestival = jourDeFestival
        self.zone = zone
    }
    
    
    
}

enum FestivalStates{
    case Init
    case Update(String,Int)
    case Created
    case Error
}

