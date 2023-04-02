//
//  CreneauxListIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 21/03/2023.
//

import Foundation
import SwiftUI



class CreneauxListIntent{
    @ObservedObject var creneauxList:CreneauxListModel
    
    
    init(creneauxList: CreneauxListModel) {
        self.creneauxList = creneauxList
    }
    
    func getCreneaux(festivalDay:JourDeFestivalModel,benevole:BenevoleModel){
    let creneauxListDAO=CreneauxListDAO()
        Task{
            guard let data = try? await creneauxListDAO.getAll(festivalDay:festivalDay) else{print("nan");return};
            if(data.isEmpty){
                self.creneauxList.uiState = .Empty
                return
            }
            self.creneauxList.uiState = .Loading(data)
            for i in 0...data.count-1{
                self.creneauxList.creneaux[i].uiState = .Init
                let singleCreneaux:CreneauxModel=self.creneauxList.creneaux[i]
                if(singleCreneaux.benevolesIds.count > 0){
                    print(singleCreneaux.benevolesIds.count)
                    for j in 0...singleCreneaux.benevolesIds.count-1{
                        if(singleCreneaux.benevolesIds[j]==benevole.id){
                            self.creneauxList.uiState = .ChanginOne(singleCreneaux,.Registered)
                        }
                    }
                }
            }
        }
    }
    
    
    func getCreneauxAdmin(festivalDay:JourDeFestivalModel){
        let creneauxListDAO: CreneauxListDAO = CreneauxListDAO()
        let benevoleDAO:BenevolesDAO=BenevolesDAO()
        Task{
            guard let data = try? await creneauxListDAO.getAll(festivalDay:festivalDay) else {print("non");return;}
            for i in 0...data.count-1{
                guard let benevoles = try? await benevoleDAO.getAll(creneau:data[i]) else{return};
                data[i].benevoles.append(contentsOf:benevoles)
            }
            self.creneauxList.uiState = .Loading(data)
        }
        
    }
    func register(benevole:BenevoleModel,creneau:CreneauxModel){
        let benevoleDAO:BenevolesDAO=BenevolesDAO()
        Task{
            guard let data = try? await benevoleDAO.register(benevole:benevole,creneaux: creneau) else{print("nan");return};
            if(data){
                print("success")
                self.creneauxList.uiState = .ChanginOne(creneau,.Registered)
            }
            
        }
    }
     
    
    func loadState(creneau:CreneauxModel,benevole:BenevoleModel){
        if(self.creneauxList.creneaux.isEmpty){
            self.creneauxList.uiState = .Empty
            return
        }
        
        for i in 0...self.creneauxList.creneaux.count-1{
            let singleCreneaux:CreneauxModel=self.creneauxList.creneaux[i]
            if(singleCreneaux.benevolesIds.count > 0){
                print(singleCreneaux.benevolesIds.count)
                for j in 0...singleCreneaux.benevolesIds.count-1{
                    if(singleCreneaux.benevolesIds[j]==benevole.id){
                        print(singleCreneaux.benevolesIds[j])
                        self.creneauxList.uiState = .ChanginOne(singleCreneaux,.Registered)
                    }
                        
                }
            }
        }
    
        
        
        
    }
    
    
    
    func deleteRegistration(benevole:BenevoleModel,creneau:CreneauxModel){
        
        let benevoleDAO:BenevolesDAO=BenevolesDAO()
        Task{
            guard let data = try? await benevoleDAO.deleteAffectation(benevole: benevole, creneaux: creneau) else{print("nan");return}
        }
        self.creneauxList.uiState = .ChanginOne(creneau,.Init)
        
    }
    
   
}
