//
//  FestivalIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 20/03/2023.

import Foundation
import SwiftUI

class FestivalIntent{
    @ObservedObject var festival:FestivalModel
    
    init(festival: FestivalModel) {
        self.festival = festival
    }
    
    func create(nom:String,annee:Int,zone:ZoneModel){
        var zones:[ZoneModel] = []
        zones.append(zone)
        print(zone.id)
        let festivalDAO:FestivalDAO=FestivalDAO()
        Task{
            guard let data = try? await festivalDAO.create(nom: nom, annee: annee, zones: zones) else{print("nan");return};
            if(data=="success"){
                self.festival.uiState = .Created}
            else{self.festival.uiState = .Error}
        }
    }
    func update(nom:String,annee:Int){
        let festivalDAO:FestivalDAO=FestivalDAO()
        self.festival.nom=nom
        self.festival.annee=annee
        Task{
            guard let updatedFestival = try? await festivalDAO.update(festival: self.festival) else{print("BUG");return};
            print(updatedFestival.nom)
            self.festival.uiState = .Update(updatedFestival.nom,updatedFestival.annee)
            
        }
    }
}

