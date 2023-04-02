//
//  CreneauxListModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 21/03/2023.
//

import Foundation
import SwiftUI

class CreneauxListModel:ObservableObject,Identifiable{
    

    
    @Published var creneaux:[CreneauxModel]
    @Published var uiState:CreneauxListStates = .Init{
        didSet{
            switch uiState{
            case .Loading(let creneauxList):
                self.creneaux=creneauxList
            case .ChanginOne(let creneaux, let state):
                updateCreneauxState(creneau: creneaux, state: state)
            default:break
            }
        }
    }
    
    init(creneaux: [CreneauxModel]) {
        self.creneaux = creneaux
    }
    
    func updateCreneauxState(creneau:CreneauxModel,state:CreneauxStates){
        if let index = creneaux.firstIndex(where: { $0.id == creneau.id }) {
            print("al")
            self.creneaux[index].uiState = state
        }
    }
    
    
}

enum CreneauxListStates:Equatable{
    case Init
    case Loading([CreneauxModel])
    case ChanginOne(CreneauxModel,CreneauxStates)
    case Empty
}
