//
//  FestivalDetailView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 19/03/2023.
//

import SwiftUI

struct FestivalDetailView: View {
    
    @ObservedObject var festival:FestivalModel
    private var festivalIntent:FestivalIntent
    private var festivalListIntent:FestivalListIntent

 
    init(festival: FestivalModel,festivalListIntent:FestivalListIntent) {
        self.festivalListIntent=festivalListIntent
        self.festival = festival
        self.festivalIntent=FestivalIntent(festival: festival)
    }
    
    var body: some View {
        
        

        VStack(alignment: .leading, spacing: 20){
            Text(festival.nom).bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title).toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination:FestivalUpdateView()) {
                    Text("modify this festival")
                }
            }
            }
            FestivalDayListView(festival:festival,isAdmin: true,benevoleIntent: nil,festivalIntent:festivalIntent)
        }
        }
    }



