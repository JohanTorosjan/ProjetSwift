//
//  CreneauxListDAO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 21/03/2023.
//

import Foundation
import SwiftUI
class CreneauxListDAO{
    private var apiUrl:URL
    
    init() {
        guard let apiUrl=URL(string:"http://localhost:3000/jourDeFestival") else{
            fatalError("Missing URL")
        }
        self.apiUrl = apiUrl
    }
    
    
    func getAll(festivalDay:JourDeFestivalModel) async throws -> [CreneauxModel]?{
        guard let creneauxURL:URL = URL(string:self.apiUrl.absoluteString+"/events/"+festivalDay.id) else{fatalError("Missing URL")}
        var creneaux:[CreneauxModel]=[]
        let urlResquest:URLRequest=URLRequest(url:creneauxURL)
        let (data,response) = try await URLSession.shared.data(for: urlResquest)
        guard(response as? HTTPURLResponse)?.statusCode == 200 else { print("here");throw ApiError.Failed }
        let decoder = JSONDecoder() // création d'un décodeur
        let decoded = try? decoder.decode([EventsDTO].self,from:data)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let creneauxDTO=decoded else{print("non");return creneaux}
        guard creneauxDTO.count>0 else{print("ici vide");return creneaux}
        for i in 0...creneauxDTO.count-1{
            if let beginingdate = dateFormatter.date(from: creneauxDTO[i].beginingdate) {
                if let endingdate = dateFormatter.date(from: creneauxDTO[i].endingdate) {
                    let benevolesIds:[String] = creneauxDTO[i].benevoles

                    let zone:ZoneModel = ZoneModel(id: creneauxDTO[i].zone._id, nom: creneauxDTO[i].zone.nom, nbrvol: creneauxDTO[i].zone.nombreBenevolesNecessaire)
                    
                    let creneau:CreneauxModel=CreneauxModel(id:creneauxDTO[i]._id,beginingdate: beginingdate, endingdate:endingdate, zone: zone, benevoles: [])
                        creneau.benevolesIds=benevolesIds
                        creneaux.append(creneau)
                } else {
                    print("Impossible de créer la date à partir de la chaîne.")
                }
            } else {
                print("Impossible de créer la date à partir de la chaîne.")
            }
       }

       return creneaux
        
   }
    
    
    func updateZone(zone:ZoneModel,creneaux:CreneauxModel) async throws -> String?{
       
        guard let creneauxURL:URL = URL(string:"http://localhost:3000/event/updateZone/"+creneaux.id) else{fatalError("Missing URL")}
        var urlResquest:URLRequest=URLRequest(url:creneauxURL)
        urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlResquest.httpMethod="PUT"
        let zoneDTO:ZoneDTO = ZoneDTO(_id: zone.id, nom: zone.nom, nombreBenevolesNecessaire: zone.nbrvol)
        print(zoneDTO._id)
        guard let encoded=try? JSONEncoder().encode(zoneDTO) else{print("pas encoded");throw ApiError.Failed}
        let(data,response)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
        guard(response as? HTTPURLResponse)?.statusCode == 200 else { print("here");throw ApiError.Failed }
        return "success"
    }
}
    
