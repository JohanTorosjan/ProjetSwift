//
//  FestivalFormView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 23/03/2023.
//

import SwiftUI
import AlertToast

struct FestivalFormView: View {
    
    @State private var showPopover = false
    @ObservedObject var festival:FestivalModel
    private var festivalIntent:FestivalIntent
    private var festivalListIntent:FestivalListIntent
    @State private var nom:String=""
    @State private var annee:Int=2023
    @State private var zone:ZoneModel=ZoneModel(id:"64203e0ea95aa7a14fb7767f", nom: "Free", nbrvol: 0)
    @State private var nomZone:String=""
    @State private var nbrbenevolesZone:Int=1
    
    @State private var showingZoneCreator = false

    let years = Array(2023...2050)
    
    @ObservedObject var zoneList:ZoneListModel
    private var zoneListIntent:ZoneListIntent
    
    init(festivalListIntent:FestivalListIntent) {
        self.festivalListIntent = festivalListIntent
        
        var festivalLoader:FestivalModel = FestivalModel(id: "", nom:"Festival of", annee: 2023, jourDeFestival: [],zone: [])
        self.festival = festivalLoader
        self.festivalIntent = FestivalIntent(festival: festivalLoader)
        
        
        let zoneListLoader:ZoneListModel = ZoneListModel(zones:[])
        
        self.zoneList = zoneListLoader
        self.zoneListIntent = ZoneListIntent(zoneList: zoneListLoader)
        
    }
    
    
    var body: some View {
        
        VStack{
            Text("Add a festival").bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)

        Form{
            HStack{
                TextField("Festival name:", text: $nom)
            }
            HStack{
                Picker("Year: ", selection: $annee) {
                    ForEach(years, id: \.self) { year in
                        Text("\(year)").tag(year)
                    }
                }
            }
            HStack{
                Picker("Zone :", selection: $zone) {
                    ForEach(zoneList.zones, id: \.self) { zone in
                        Text(zone.nom).tag(zone)    
                    }
                }
            }.onAppear(){
                zoneListIntent.getZones(festival: festivalIntent.festival)
            }
            Button("add a new zone"){
                showingZoneCreator = true
                
            }.popover(isPresented: $showingZoneCreator){
                Section{
                    Text("Add a zone").bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)
                    Form{
                        HStack{
                            TextField("Zone name:", text: $nomZone)
                        }
                        
                        HStack{
                            Picker("Number of benevoles needed", selection: $nbrbenevolesZone) {
                                ForEach(0..<2001) { number in
                                    Text("\(number)").tag(number)
                                }
                            }.padding(.bottom,20)
                        }
                        Button("Add a zone"){
                            zoneListIntent.addZone(nom:nomZone,nbrbenevolesZone:nbrbenevolesZone)
                            showingZoneCreator = false
                        }
                    }
                }
            }
        }




            
            Button("Create"){
               
                festivalIntent.create(nom:nom,annee:annee,zone:zone)
                showPopover.toggle()
            }.padding().background(Color.blue).cornerRadius(10).tint(.white)
        }.onDisappear(perform: festivalListIntent.getFestivalList).toast(isPresenting: $showPopover){
            AlertToast(type: .regular, title: "Festival created !")
        }.background(Color.white)
    }
}
