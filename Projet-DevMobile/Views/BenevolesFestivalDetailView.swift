//
//  BenevolesFestivalDetailView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 21/03/2023.
//

import SwiftUI

struct BenevolesFestivalDetailView: View {
    @ObservedObject var festival:FestivalModel
    
    private var benevoleIntent:BenevoleIntent
    
    init(festival: FestivalModel, benevoleIntent: BenevoleIntent) {
        self.festival = festival
        self.benevoleIntent = benevoleIntent
    }
    var body: some View {
        Text(festival.nom).bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)
            VStack(alignment: .leading, spacing: 20){
                FestivalDayListView(festival: festival,isAdmin: false,benevoleIntent: benevoleIntent,festivalIntent: nil)
            }
        
    }
}


