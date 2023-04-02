//
//  CreneauxModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 21/03/2023.
//
import Foundation
import SwiftUI

class CreneauxModel:ObservableObject,Identifiable,Hashable{
    // Cette fonction est nécessaire pour rendre le modèle conforme à Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        // Cette fonction est également nécessaire pour rendre le modèle conforme à Hashable
        static func == (lhs: CreneauxModel, rhs: CreneauxModel) -> Bool {
            lhs.id == rhs.id
        }

    public var benevolesIds:[String]=[]
    @Published public var id:String
    @Published public var beginingdate:Date
    @Published public var endingdate:Date
    @Published public var zone:ZoneModel
    @Published public var benevoles:[BenevoleModel]
    
    @Published public var uiState:CreneauxStates = .Init{
        didSet{
            switch uiState{
            case .Init:
                self.uiState = .Loaded
            
         
          
            case .Loaded:
                print("loaded")
            
            case .Registered:
            print(uiState)
            
            case .Full:
                print("full")
                
            }
     
        }
    
    }
    

    init(id:String,beginingdate: Date, endingdate: Date, zone: ZoneModel, benevoles: [BenevoleModel]) {
        self.beginingdate = beginingdate
        self.id=id
        self.endingdate = endingdate
        self.zone = zone
        self.benevoles = benevoles
    }
    
    
    func deleteBenevole(benevole:BenevoleModel){
        if let index = self.benevoles.firstIndex(where: { $0.id == benevole.id }) {
            self.benevoles.remove(at: index)
        }
    }
    
}
enum CreneauxStates{
    case Init
    case Registered
    case Loaded
    case Full
   // case LoadBenevoles([BenevoleModel])
}
