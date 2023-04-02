//
//  BenevolesListModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 16/03/2023.
//
import Foundation
import SwiftUI

class BenevolesListModel:ObservableObject,Identifiable{
    @Published var benevoles:[BenevoleModel]
    @Published var uiState:BenevolesListStates = .Init{
        didSet{
            switch uiState{
            case .Loading(let benevoles):
                self.benevoles=benevoles
            default:break
            }
        }
    }
    init(benevoles: [BenevoleModel]) {
        self.benevoles = benevoles
    }
}

enum BenevolesListStates{
    case Init
    case Loading([BenevoleModel])
    case Loaded
}
