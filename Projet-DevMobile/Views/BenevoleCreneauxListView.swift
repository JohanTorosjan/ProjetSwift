//
//  BenevoleCreneauxListView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 22/03/2023.
//

import SwiftUI

struct BenevoleCreneauxListView: View {
    
    
    @State private var isDisabled:Bool
    
    @ObservedObject var creneauxList:CreneauxListModel
    @ObservedObject var festivalDay:JourDeFestivalModel
    private var creneauxListIntent:CreneauxListIntent
    private var dateFormatter=DateFormatter()
    private var benevoleIntent:BenevoleIntent
    
   
    
    init(festivalDay: JourDeFestivalModel,benevoleIntent:BenevoleIntent) {
        let creneauxListLoader:CreneauxListModel=CreneauxListModel(creneaux: [])
        self.creneauxList = creneauxListLoader
        self.dateFormatter.dateFormat = "HH.mm"
        self.festivalDay = festivalDay
        self.creneauxListIntent = CreneauxListIntent(creneauxList:creneauxListLoader)
        self.isDisabled=true
        self.benevoleIntent=benevoleIntent
        
        
    }
    
    var body: some View {
       
        
        VStack(alignment: .leading, spacing: 20){
           
           
           
            if(creneauxList.uiState == .Empty){
                Text("Nothing for the moment ...").bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)
            }
            else{
                Text(festivalDay.nom).bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)
                List(creneauxList.creneaux, id: \.self) { creneau in
                    HStack{
                        Text("From "+dateFormatter.string(from: creneau.beginingdate)+" to "+dateFormatter.string(from: creneau.endingdate))
                        Text("in "+creneau.zone.nom)
                        
                    }
                    VStack(alignment: .leading, spacing:20){
                        switch creneau.uiState{
                       
                        case .Init:
                            ProgressView("Loading...")
                                .progressViewStyle(CircularProgressViewStyle())
                        case .Loaded:
                            VStack{
                                Button(action:
                                        {
                                    creneauxListIntent.register(benevole: benevoleIntent.benevole,creneau:creneau)
                                    
                                }
                                )
                                {Text("Choose this time slot").foregroundColor(.white)}
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            
                        case .Registered:
                            VStack{
                                Button(action:
                                        { creneauxListIntent.deleteRegistration(benevole: benevoleIntent.benevole,creneau:creneau)
                                }
                                )
                                {Text("Cancel").foregroundColor(.white)}
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        case .Full:
                            VStack{
                                Button(action:{})
                                {Text("full for now...").foregroundColor(.white)}
                                    .padding()
                                    .background(Color.gray)
                                    .cornerRadius(10)
                            }.foregroundColor(Color.gray)
                        default:
                            Text("bug")
                        }
                    }.onAppear(){creneauxListIntent.loadState(creneau:creneau,benevole:benevoleIntent.benevole)}.onDisappear()
                    
                }
            }
        }.onAppear{creneauxListIntent.getCreneaux(festivalDay:festivalDay,benevole:benevoleIntent.benevole)}
    }
}


