//
//  BenevolesListIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 16/03/2023.
//

import Foundation
import SwiftUI

class BenevolesListIntent{
   
    @ObservedObject var benevolesList:BenevolesListModel
    
    
    init(benevolesList: BenevolesListModel) {
        self.benevolesList = benevolesList
    }
    
    func getBenevolesList(creneau:CreneauxModel){
        let benevoleDAO:BenevolesDAO=BenevolesDAO()
        Task{
            guard let data = try? await benevoleDAO.getAll(creneau:creneau) else{return};
            print("AAAA")
            print(data[0].nom)
            print("AAAA")
            self.benevolesList.uiState = .Loading(data)
        }
    }
    
}
