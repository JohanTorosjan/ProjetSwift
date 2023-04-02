//
//  BenevolesListView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 16/03/2023.
//

import SwiftUI
import Foundation
struct BenevolesListView: View {
    @ObservedObject var benevolesList:BenevolesListModel
    private var benevolesListIntent:BenevolesListIntent
    
    private var creneau:CreneauxModel
    init(creneau:CreneauxModel) {
        let benevoleListLoader:BenevolesListModel = BenevolesListModel(benevoles:[])
        self.benevolesList = benevoleListLoader
        self.benevolesListIntent = BenevolesListIntent(benevolesList: benevoleListLoader)
        self.creneau = creneau
    }
    var body: some View {
            VStack{
                VStack{
                    Text("Benevoles assigned :")
                    List(benevolesList.benevoles){benevole in
                        Text(benevole.nom+" "+benevole.prenom)
                    }
                }
            
            }.onAppear(){
                benevolesListIntent.getBenevolesList(creneau:creneau)
                print("ertghcfgvncfgvbgtfcygtfcfghvyg")
            }
            
               
                
            

    }
}

