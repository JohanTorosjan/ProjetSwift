//
//  BenevolesDAO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 16/03/2023.
//

import Foundation
import SwiftUI

class BenevolesDAO{
   
    private var apiUrl:URL
    @State private var benevoles:[BenevoleModel]=[]
    init() {
        guard let apiUrl=URL(string:"http://localhost:3000/benevole") else{
            fatalError("Missing URL")
        }
        self.apiUrl = apiUrl
    }
    
    
    func getAll(creneau:CreneauxModel) async throws -> [BenevoleModel]{
       
        var benevoles:[BenevoleModel]=[]
        guard let getUrl:URL = URL(string:"http://localhost:3000/event/ListOfBenevoles/"+creneau.id) else{fatalError("Missing URL")}
        let urlResquest:URLRequest=URLRequest(url:getUrl)
        let (data,response) = try await URLSession.shared.data(for: urlResquest)
        guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw ApiError.Failed }
        let decoder = JSONDecoder() // création d'un décodeur
        let decoded = try? decoder.decode([BenevolesDTO].self,from:data)
        guard let benevolesDTO=decoded else{return benevoles}
        if(benevolesDTO.count<1){
            return benevoles
        }
        for i in 0...benevolesDTO.count-1{
            let benevole:BenevoleModel=BenevoleModel(id: benevolesDTO[i]._id, prenom: benevolesDTO[i].prenom, nom: benevolesDTO[i].nom,email: benevolesDTO[i].email)
            benevoles.append(benevole)
        }
        return benevoles
    }
    
    func register(benevole:BenevoleModel,creneaux:CreneauxModel) async throws -> Bool{
        guard let putURL:URL = URL(string:"http://localhost:3000/event/addBenevoles/"+creneaux.id) else{fatalError("Missing URL")}
       

        var benevoleDTO:BenevolesDTO=BenevolesDTO(_id:benevole.id, prenom: benevole.prenom, nom: benevole.nom, email: benevole.email)
        guard let encoded=try? JSONEncoder().encode(benevoleDTO) else{print("pas encoded");return false}
        var urlResquest:URLRequest=URLRequest(url:putURL)
          urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
          urlResquest.httpMethod="PUT"
        do{
            var message:String
            let(data,_)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
            let decoder = JSONDecoder() // création d'un décodeur
            let decoded = try? decoder.decode(MessageDTO.self,from:data)
            guard let message=decoded else{print("non");return false}
            if(message.message=="success"){
                return true
            }
            
        }
        catch{
            throw ApiError.Failed
        }
        return false
    }
    
    func deleteAffectation(benevole:BenevoleModel,creneaux:CreneauxModel) async throws -> Bool{
        guard let putURL:URL = URL(string:"http://localhost:3000/event/deleteAffectation/"+creneaux.id) else{fatalError("Missing URL")}
        var benevoleDTO:BenevolesDTO=BenevolesDTO(_id:benevole.id, prenom: benevole.prenom, nom: benevole.nom, email: benevole.email)
        guard let encoded=try? JSONEncoder().encode(benevoleDTO) else{print("pas encoded");return false}
        var urlResquest:URLRequest=URLRequest(url:putURL)
          urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
          urlResquest.httpMethod="DELETE"
        do{
            var message:String
            let(data,_)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
            let decoder = JSONDecoder() // création d'un décodeur
            let decoded = try? decoder.decode(MessageDTO.self,from:data)
            guard let message=decoded else{print("non");return false}
            if(message.message=="success"){
                return true
            }
            
        }
        catch{
            throw ApiError.Failed
        }
        return false
    }
    
    
    
    func createAccount(nom:String,prenom:String,email:String,password:String) async throws -> BenevoleModel?{
       
        var urlResquest:URLRequest=URLRequest(url:apiUrl)
        var benevoleDTO:CreateBenevoleDTO = CreateBenevoleDTO(prenom: prenom, nom: nom, email: email, password: password)
        guard let encoded=try? JSONEncoder().encode(benevoleDTO) else{print("pas encoded");throw ApiError.Failed}
        urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlResquest.httpMethod="POST"
        let(data,_)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
        let decoded = try? JSONDecoder().decode(BenevolesDTO.self,from:data)
        guard let benevole=decoded else{print("non");return nil}
        print("ok")
        return BenevoleModel(id: benevole._id, prenom: benevole.prenom, nom: benevole.nom, email: benevole.email)
    }
    
    func login(email:String,password:String) async throws -> BenevoleModel{
        guard let url:URL = URL(string:"http://localhost:3000/benevole/login") else{fatalError("Missing URL")}
        var urlResquest:URLRequest=URLRequest(url:url)
        var benevoleDTO:CreateBenevoleDTO = CreateBenevoleDTO(prenom: "", nom: "", email: email, password: password)
        guard let encoded=try? JSONEncoder().encode(benevoleDTO) else{print("pas encoded");throw ApiError.Failed}
        urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlResquest.httpMethod="POST"
        let(data,_)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
        let decoded = try? JSONDecoder().decode(BenevolesDTO.self,from:data)
        guard let benevole=decoded else{print("non");throw ApiError.Failed}
        print("ok")
        return BenevoleModel(id: benevole._id, prenom: benevole.prenom, nom: benevole.nom, email: benevole.email)
    }
        
    
    
    
    
}
