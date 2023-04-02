//
//  FestivalListView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import SwiftUI

struct FestivalListView: View {
    
    @ObservedObject var festivalList:FestivalListModel
    private var festivalListIntent:FestivalListIntent
    private var isAdmin:Bool
    private var benevoleIntent:BenevoleIntent?
    
    init(isAdmin:Bool,benevoleIntent:BenevoleIntent?) {
        let festivalListLoader:FestivalListModel = FestivalListModel(festivals:[])
        let festivalListIntentLoader = FestivalListIntent(festivalList:festivalListLoader)
        self.festivalList = festivalListLoader
        self.festivalListIntent = festivalListIntentLoader
        
        self.isAdmin=isAdmin
        
        self.benevoleIntent=benevoleIntent
    }
    var body: some View {
        
        VStack(alignment: .leading,spacing: 20){
            
            
            NavigationView{
                VStack{
                    if(isAdmin==true){
                        Text("Manage your festivals ").bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title).toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination:FestivalFormView(festivalListIntent: festivalListIntent)){
                                    Text("add a festival")
                                }
                            }
                        }
                    }
                    else{
                        Text("Register to a festival").bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)
                    }
              
                    List(festivalList.festivals){festival in
                        if(isAdmin==true){
                            NavigationLink(destination:FestivalDetailView(festival: festival,festivalListIntent: festivalListIntent)){
                                Text(festival.nom)
                            }
                        }
                        else{
                            NavigationLink(destination:BenevolesFestivalDetailView(festival: festival,benevoleIntent:benevoleIntent!)){
                                Text(festival.nom)
                                
                            }
                        }
                    }.refreshable {
                        festivalListIntent.getFestivalList()
                    }
                }
            }
        }.onAppear(perform:festivalListIntent.getFestivalList).onDisappear(perform: festivalListIntent.getFestivalList)
    }
}
