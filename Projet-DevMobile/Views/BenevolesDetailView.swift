//
//  BenevolesDetailView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 17/03/2023.
//

import SwiftUI

struct BenevolesDetailView: View {
    @ObservedObject var benevole:BenevoleModel
    @State private var nom=""
    @State private var prenom=""
    @State private var email=""
    
    init(benevole: BenevoleModel) {
        self.benevole = benevole
    }
    var body: some View {
        
        VStack{
            NavigationView {
                       Form {
                           Section(header: Text("Update "+benevole.nom+" informations")) {
                               TextField(benevole.nom, text: $nom)
                               TextField(benevole.prenom, text:$prenom)
                               TextField(benevole.email, text: $email)
                           }
                       }
                   }
        }
      
    }
}

