//
//  ZoneListIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 26/03/2023.
//


import Foundation
import SwiftUI

class ZoneListIntent{
    @ObservedObject var zoneList:ZoneListModel
    init(zoneList: ZoneListModel) {
        self.zoneList = zoneList
    }
    
    func getZones(festival:FestivalModel){
        print(festival.id)
        let festivalDAO:FestivalDAO = FestivalDAO()
        Task{
            guard let data = try? await festivalDAO.getZones(festival:festival) else{print("nan");return};
            print(data)
            self.zoneList.uiState = .Loading(data)
        }
    }
    
    
    func addZone(nom:String,nbrbenevolesZone:Int){
        let zoneDAO:ZonesDAO = ZonesDAO()
        Task{
            guard let data = try? await zoneDAO.add(nom:nom, nbrbenevolesZone:nbrbenevolesZone) else{print("nan");return};
            self.zoneList.uiState = .AddOne(data)
        }
    }
    
    
    func pushZone(nom:String,nbrbenevolesZone:Int,festival:FestivalModel){
    
    let zoneDAO:ZonesDAO = ZonesDAO()
    
    Task{
        guard let data = try? await zoneDAO.pushZone(nom:nom, nbrbenevolesZone: nbrbenevolesZone,festival:festival)else{print("non");return;}
            self.zoneList.uiState = .AddOne(data)
            
        }
    }

          
}
