//
//  ZoneListView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 26/03/2023.
//

import SwiftUI

struct ZoneListView: View {
    
    @ObservedObject var zoneList:ZoneListModel
    
    private var zoneListIntent:ZoneListIntent
    
    private var festivalIntent:FestivalIntent
    
    init(festivalIntent: FestivalIntent) {
        self.festivalIntent = festivalIntent
        let zoneListLoader:ZoneListModel = ZoneListModel(zones:[])
      
        self.zoneList = zoneListLoader
        self.zoneListIntent = ZoneListIntent(zoneList: zoneListLoader)
       
    }
    
    var body: some View {
        
        HStack{
            VStack{
                Text("Free - (by defaut)")
                List(zoneList.zones){ zone in
                    Text(zone.nom)
                }
            }
            
            
        }.onAppear(){
            zoneListIntent.getZones(festival: festivalIntent.festival)
            
        }
        
        
    }
}

