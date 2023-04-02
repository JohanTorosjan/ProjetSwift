//
//  ZoneListModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 26/03/2023.
//

import Foundation

class ZoneListModel:ObservableObject,Identifiable{
    
    

    
    @Published var zones:[ZoneModel]
    @Published var uiState:ZoneListStates = .Init{
        didSet{
            switch uiState{
            case .Loading(let zones):
                self.zones=zones
            case .AddOne(let zone):
                self.zones.append(zone)
            default:break
            }
        }
    }
    
    init(zones: [ZoneModel]) {
        self.zones = zones
    }
    
    
    
}

enum ZoneListStates{
    case Init
    case Loading([ZoneModel])
    case AddOne(ZoneModel)
}
