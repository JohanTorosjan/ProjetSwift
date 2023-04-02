//
//  CreneauxListView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 21/03/2023.
//

import SwiftUI

struct CreneauxListView: View {
    
    @ObservedObject var creneauxList:CreneauxListModel
    @ObservedObject var festivalDay:JourDeFestivalModel
    private var festivalIntent:FestivalIntent
    private var creneauxListIntent:CreneauxListIntent
    private var dateFormatter=DateFormatter()
    
    init(festivalDay: JourDeFestivalModel, festivalIntent: FestivalIntent) {
        let creneauxListLoader:CreneauxListModel=CreneauxListModel(creneaux: [])
        self.creneauxList = creneauxListLoader
        self.dateFormatter.dateFormat = "HH.mm"
        self.festivalDay = festivalDay
        self.creneauxListIntent = CreneauxListIntent(creneauxList:creneauxListLoader)
     
        self.festivalIntent = festivalIntent
        
    }
    
    var body: some View {
        VStack{
                List(creneauxList.creneaux){creneau in
                    NavigationLink(destination:CreneauxDetailView(creneau: creneau, festivalIntent: festivalIntent,creneauListIntent:creneauxListIntent,festivalDay: festivalDay)){
                        Text(dateFormatter.string(from: creneau.beginingdate)+" -")
                        Text(dateFormatter.string(from: creneau.endingdate))
                        Text(" in "+creneau.zone.nom)
                    }
                }
        }.onAppear{creneauxListIntent.getCreneauxAdmin(festivalDay:festivalDay)}
        
    }
}

