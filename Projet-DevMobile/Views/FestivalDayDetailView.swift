//
//  FestivalDayDetailView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 20/03/2023.
//

import SwiftUI

struct FestivalDayDetailView: View {
    
    
    
    @ObservedObject var festivalDay:JourDeFestivalModel
    private var festivalDayIntent:FestivalDayIntent
    private var festivalDayListIntent:FestivalDayListIntent
    private var festival:FestivalModel
    private var dateFormatter:DateFormatter=DateFormatter()
    private var dateDayFormatter:DateFormatter=DateFormatter()
    
    private var festivalIntent:FestivalIntent

    init(festivalDay: JourDeFestivalModel,festivalDayListIntent: FestivalDayListIntent,festival:FestivalModel,festivalIntent:FestivalIntent) {
      
        self.festivalDayListIntent = festivalDayListIntent
        self.festival=festival
        self.dateFormatter.dateFormat = "HH.mm"
        self.festivalDayIntent = FestivalDayIntent(festivalDay: festivalDay)
        self.festivalDay = festivalDay
        self.dateDayFormatter.dateFormat = "EEEE d MMM yyyy"
        
        self.festivalIntent = festivalIntent
       
       
    }
 
    var body: some View {
        VStack{
            Text(festivalDay.nom).bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)
            Text(dateDayFormatter.string(from: festivalDay.beginingdate))
            Text("From "+dateFormatter.string(from: festivalDay.beginingdate)+" to "+dateFormatter.string(from: festivalDay.endingdate))
                
            VStack{
                CreneauxListView(festivalDay: festivalDay,festivalIntent: festivalIntent)
            }
        }.onDisappear{
            festivalDayListIntent.getFestivalDays(festival:festival)
        }
    }
}



