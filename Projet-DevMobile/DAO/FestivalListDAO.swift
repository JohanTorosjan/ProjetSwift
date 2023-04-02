//
//  FestivalListDAO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI

class FestivalListDAO{
    
     private var apiUrl:URL
     @State private var festivals:[FestivalModel]=[]
     init() {
         guard let apiUrl=URL(string:"http://localhost:3000/festival") else{
             fatalError("Missing URL")
         }
         self.apiUrl = apiUrl
     }
    
    private func BuildJourDeFestival(jourDeFestival:JourDeFestivalDTO){
        
    }
     
    func getAll() async throws -> [FestivalModel]{
        var festivals:[FestivalModel]=[]
        let urlResquest:URLRequest=URLRequest(url:apiUrl)
        let (data,response) = try await URLSession.shared.data(for: urlResquest)
        guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw ApiError.Failed }
        let decoder = JSONDecoder() // création d'un décodeur
        let decoded = try? decoder.decode([FestivalDTO].self,from:data)
        guard let festivalDTO=decoded else{print("non");return festivals}
        if(festivalDTO.count==0){
           return festivals
            
        }
        for i in 0...festivalDTO.count-1{
            let festival:FestivalModel=FestivalModel(id:festivalDTO[i]._id, nom: festivalDTO[i].nom, annee: festivalDTO[i].annee,jourDeFestival: [], zone:[])
                festivals.append(festival)
        }
        return festivals
    }
    
    

}
