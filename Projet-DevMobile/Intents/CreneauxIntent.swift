//
//  CreneauxIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 22/03/2023.
//

import Foundation
import SwiftUI


class CreneauxIntent{
    
    @ObservedObject var creneaux:CreneauxModel
    
    init(creneaux: CreneauxModel) {
        self.creneaux = creneaux
    }
    
    
    func register(benevole:BenevoleModel){
        let benevoleDAO:BenevolesDAO=BenevolesDAO()
        Task{
            guard let data = try? await benevoleDAO.register(benevole:benevole,creneaux: self.creneaux) else{print("nan");return};
            print(data)
            self.creneaux.uiState = .Registered
        }
    }
    
    func loadState(benevole:BenevoleModel){
        print("aa")
        self.creneaux.uiState = .Loaded
        
    }
    
    /*
    func deleteRegistration(benevole:BenevoleModel){
        self.creneaux.uiState = .Loaded
    }
    */
    func getBenevoles(creneau:CreneauxModel){
        let benevoleDAO:BenevolesDAO=BenevolesDAO()
        Task{
            guard let data = try? await benevoleDAO.getAll(creneau:creneau) else{return};
            print("AAAA")
            print(data[0].nom)
            print("AAAA")
           // self.creneaux.uiState = .LoadBenevoles(data)
        }
    }
    
    
    func deleteRegistration(benevole:BenevoleModel){
        let benevoleDAO:BenevolesDAO=BenevolesDAO()
        Task{
            guard let data = try? await benevoleDAO.deleteAffectation(benevole: benevole, creneaux: self.creneaux) else{print("nan");return}
            print(data)
        }
        self.creneaux.deleteBenevole(benevole: benevole)
    }
    
    
    func updateZone(zone:ZoneModel){
        let creneauxListDAO:CreneauxListDAO = CreneauxListDAO()
        Task{
            guard let data = try? await creneauxListDAO.updateZone(zone:zone,creneaux:self.creneaux) else{ return;}
            print(data)
        }
    }
}
