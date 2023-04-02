//
//  CreneauxDetailView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 21/03/2023.
//

import SwiftUI

struct CreneauxDetailView: View {
    
    @ObservedObject var creneau:CreneauxModel
    private var creneauIntent:CreneauxIntent
    private var dateFormatter=DateFormatter()
    private var creneauListIntent:CreneauxListIntent
    
    private var festivalDay:JourDeFestivalModel
    
    /// ZONE RELATED
    @State private var zone:ZoneModel
    
    @State private var showingZoneCreator = false
    @State private var nomZone:String=""
    @State private var nbrbenevolesZone:Int=1
    @ObservedObject var zoneList:ZoneListModel
    private var zoneListIntent:ZoneListIntent
    private var festivalIntent:FestivalIntent
    ///
    
    init(creneau:CreneauxModel,festivalIntent: FestivalIntent,creneauListIntent:CreneauxListIntent,festivalDay:JourDeFestivalModel) {
        self.dateFormatter.dateFormat = "HH.mm"
        self.creneau = creneau
        self.creneauIntent = CreneauxIntent(creneaux: creneau)
        self.creneauListIntent = creneauListIntent
        self.festivalDay = festivalDay
        /// ZONE RELATED
        self.zone = creneau.zone
        let zoneListLoader:ZoneListModel = ZoneListModel(zones:[])
        self.zoneList = zoneListLoader
        self.zoneListIntent = ZoneListIntent(zoneList: zoneListLoader)
        self.festivalIntent = festivalIntent
        ///
    }
    var body: some View {
      
        VStack{
            VStack{
                Text(dateFormatter.string(from: creneau.beginingdate)+" - "+dateFormatter.string(from: creneau.endingdate)).bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)
            }
            VStack{
                
                VStack{
                    if(creneau.benevoles.count>0){
                        Text("Benevoles assigned :").bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)
                        List(creneau.benevoles){ benevole in
                            HStack{
                                Text("\(benevole.nom) - \(benevole.prenom) - (\(benevole.email))")
                                Button("Delete"){
                                    creneauIntent.deleteRegistration(benevole: benevole)
                                }.foregroundColor(.red)
                            }
                            
                        }
        
                    }
                    else{
                        Text("No benevoles for now").bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50)
                    }
                }
                
                Text("Number of benevoles needed : "+creneau.benevoles.count.codingKey.stringValue + "/" + zone.nbrvol.codingKey.stringValue)
                HStack{
                    Picker("Zone :", selection: $zone) {
                        ForEach(zoneList.zones, id: \.self) { zone in
                            Text(zone.nom).tag(zone)
                        }
                    }.onChange(of: zone){newZone in
                        creneauIntent.updateZone(zone:newZone)

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
                                    zoneListIntent.pushZone(nom:nomZone,nbrbenevolesZone:nbrbenevolesZone,festival:festivalIntent.festival)
                                    showingZoneCreator = false
                                }
                            }
                        }
                    }
                    
                    
                }.onAppear(){
                    zoneListIntent.getZones(festival: festivalIntent.festival)
                }
                
                
                
            }
        }.onDisappear(){
            creneauListIntent.getCreneauxAdmin(festivalDay: festivalDay)
        }
    }
}

