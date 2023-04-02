//
//  BenevoleIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 17/03/2023.
//

import Foundation
import SwiftUI

class BenevoleIntent{
    @ObservedObject var benevole:BenevoleModel
    
    
    init(benevole: BenevoleModel) {
        self.benevole = benevole
    }
    
    func register(creneaux:CreneauxModel){
        let benevoleDAO:BenevolesDAO=BenevolesDAO()
        Task{
            guard let data = try? await benevoleDAO.register(benevole:self.benevole,creneaux: creneaux) else{print("nan");return};
            print(data)
          //  self.benevole.uiState = .Register(data)
        }
    }
    
}

