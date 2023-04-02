//
//  BenevolesMainView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 21/03/2023.
//

import SwiftUI

struct BenevolesMainView: View {
    @State private var tabSelected  = 0
    @ObservedObject var benevole:BenevoleModel
    private var benevoleIntent:BenevoleIntent
    
    init(benevole: BenevoleModel) {
        self.benevole = benevole
        self.benevoleIntent = BenevoleIntent(benevole: benevole)
    }
    
    var body: some View {
       
        TabView(selection: $tabSelected){
            FestivalListView(isAdmin:false,benevoleIntent: benevoleIntent)
                .tabItem{
                    Label("Festivals", systemImage: "list.triangle")
                }.tag(1)
            BenevoleProfileView()
                .tabItem{
                    Label("Your affecations", systemImage: "paperplane")
                }.tag(0)
        }
    }
        
}

