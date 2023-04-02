//
//  FestivalListModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI

class FestivalListModel:ObservableObject,Identifiable{
    @Published var festivals:[FestivalModel]
    @Published var uiState:FestivalListStates = .Init{
        didSet{
            switch uiState{
            case .Loading(let festivals):
                self.festivals=festivals
            default:break
            }
        }
    }
    
    init(festivals: [FestivalModel]) {
        self.festivals = festivals
    }
    
    
    
}

enum FestivalListStates{
    case Init
    case Loading([FestivalModel])
}
