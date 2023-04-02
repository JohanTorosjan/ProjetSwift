//
//  AccountIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 02/04/2023.
//

import Foundation
import SwiftUI
class AccountIntent{
    @ObservedObject var benevole:BenevoleModel
    
    init(benevole: BenevoleModel) {
        self.benevole = benevole
    }
    
    func register(nom:String,prenom:String,email:String,password:String) -> Bool{
        let benevoleDAO:BenevolesDAO = BenevolesDAO()
        Task{
            guard let benevole = try? await benevoleDAO.createAccount(nom: nom, prenom: prenom, email: email, password: password) else{return;}
            
            self.benevole.uiState = .Create(benevole)
            print(benevole.nom)
        }
        return true
    }
    
    
    func login(email:String,password:String) ->Bool{
        let benevoleDAO:BenevolesDAO = BenevolesDAO()
        Task{
            guard let benevole = try? await benevoleDAO.login(email:email,password:password) else{print("al"); self.benevole.uiState = .Error; return false;}
            print("ici")
            self.benevole.uiState = .Create(benevole)
            self.benevole = benevole
            return true
        }
        return true
    }
}
