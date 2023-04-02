//
//  FestivalDayListDAO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 20/03/2023.
//

import Foundation
import SwiftUI
class FestivalDayListDAO{
    private var apiUrl:URL
    
  
   
    init() {
        guard let apiUrl=URL(string:"http://localhost:3000/festival") else{
            fatalError("Missing URL")
        }
        self.apiUrl = apiUrl
    }
   
    
    func getAll(festival:FestivalModel) async throws -> [JourDeFestivalModel]{
        guard let festivalUrl:URL = URL(string:self.apiUrl.absoluteString+"/jour/"+festival.id) else{fatalError("Missing URL")}
        var festivalDays:[JourDeFestivalModel]=[]
        let urlResquest:URLRequest=URLRequest(url:festivalUrl)
        let (data,response) = try await URLSession.shared.data(for: urlResquest)
        guard(response as? HTTPURLResponse)?.statusCode == 200 else { print("here");throw ApiError.Failed }
       let decoder = JSONDecoder() // création d'un décodeur
       let decoded = try? decoder.decode([JourDeFestivalDTO].self,from:data)
       guard let festivalDayDTO=decoded else{print("non");return festivalDays}
        guard festivalDayDTO.count>0 else{print("vide");return festivalDays}
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        for i in 0...festivalDayDTO.count-1{
            if let beginingdate = dateFormatter.date(from: festivalDayDTO[i].begining) {
                if let endingdate = dateFormatter.date(from: festivalDayDTO[i].ending) {
                    let festivalDay:JourDeFestivalModel=JourDeFestivalModel(id:festivalDayDTO[i]._id,nom: festivalDayDTO[i].nom, beginingdate: beginingdate, endingdate: endingdate, creneaux:[])
                    festivalDays.append(festivalDay)
                }
            else{print("erreur formatage de la data")}
        }
                   else{print("erreur formatage de la date")}
           
       }
       return festivalDays
   }
    
    func create(festivalDay:JourDeFestivalModel, festival: FestivalModel) async throws -> JourDeFestivalModel {
        guard let festivalDayUrl:URL = URL(string:"http://localhost:3000/jourDeFestival") else{fatalError("Missing URL")}
        var urlResquest:URLRequest=URLRequest(url:festivalDayUrl)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Format de date ISO 8601
        
        let beginingdateString = formatter.string(from: festivalDay.beginingdate)
        let endingdateString = formatter.string(from: festivalDay.endingdate)
        let festivalDayDTO:CreateFestivalDayDTO = CreateFestivalDayDTO(nom: festivalDay.nom, begining: beginingdateString, ending: endingdateString)
        guard let encoded=try? JSONEncoder().encode(festivalDayDTO) else{print("pas encoded");throw ApiError.Failed}
        urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlResquest.httpMethod="POST"

        let(data,response)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
        

        
        
        let decoded = try? JSONDecoder().decode(JourDeFestivalDTO.self,from:data)
       

        guard let newFestivalDayDTO=decoded else{print("non");throw ApiError.Failed}
        print(newFestivalDayDTO._id)
        let newFestivalDay:JourDeFestivalModel = JourDeFestivalModel(id: newFestivalDayDTO._id, nom: newFestivalDayDTO.nom, beginingdate: festivalDay.beginingdate, endingdate:festivalDay.endingdate, creneaux: [])
        return newFestivalDay
    }
    
    
}

struct Response: Codable {
    let date: Date
}
