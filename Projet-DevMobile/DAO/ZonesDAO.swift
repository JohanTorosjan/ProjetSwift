//
//  ZonesDAO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 26/03/2023.
//


import Foundation
import SwiftUI

class ZonesDAO{
    private var apiUrl:URL
    
    init() {
        guard let apiUrl=URL(string:"http://localhost:3000/zone") else{
            fatalError("Missing URL")
        }
        self.apiUrl = apiUrl
    }
    
    
    
    func add(nom:String, nbrbenevolesZone: Int) async throws -> ZoneModel{
        var urlResquest:URLRequest=URLRequest(url:apiUrl)
        var zoneDTO:ZoneDTO = ZoneDTO(_id: "", nom: nom, nombreBenevolesNecessaire: nbrbenevolesZone)
        guard let encoded=try? JSONEncoder().encode(zoneDTO) else{print("pas encoded");throw ApiError.Failed}
        urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlResquest.httpMethod="POST"
        let(data,response)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
        let decoded = try? JSONDecoder().decode(ZoneDTO.self,from:data)
        guard let newZone=decoded else{print("non");throw ApiError.Failed}
        return ZoneModel(id: newZone._id, nom: newZone.nom, nbrvol: newZone.nombreBenevolesNecessaire)
    }
    
    
    
    func pushZone(nom:String, nbrbenevolesZone: Int,festival:FestivalModel) async throws -> ZoneModel{
        
        
        var urlResquest:URLRequest=URLRequest(url:apiUrl)
        var zoneDTO:ZoneDTO = ZoneDTO(_id: "", nom: nom, nombreBenevolesNecessaire: nbrbenevolesZone)
        guard let encoded=try? JSONEncoder().encode(zoneDTO) else{print("pas encoded");throw ApiError.Failed}
        urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlResquest.httpMethod="POST"
        let(data,response)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
        let decoded = try? JSONDecoder().decode(ZoneDTO.self,from:data)
        guard let newZone=decoded else{print("non");throw ApiError.Failed}
       
        
        
        ///////
        let festivalid:String = festival.id
        guard let zoneURL:URL = URL(string:"http://localhost:3000/festival/addZone/"+festivalid) else{fatalError("Missing URL")}
        var zoneUrlResquest:URLRequest=URLRequest(url:zoneURL)
        zoneUrlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        zoneUrlResquest.httpMethod="PUT"
       
       
        let zone:ZoneModel = ZoneModel(id: newZone._id, nom: newZone.nom, nbrvol: newZone.nombreBenevolesNecessaire)
        var zonePUSHDTO:ZoneDTO = ZoneDTO(_id: zone.id, nom: zone.nom, nombreBenevolesNecessaire: zone.nbrvol)
        guard let zoneencoded=try? JSONEncoder().encode(zonePUSHDTO) else{print("pas encoded");throw ApiError.Failed}
        let(dataZone,responseZone)=try await URLSession.shared.upload(for: zoneUrlResquest, from: zoneencoded)
        guard(responseZone as? HTTPURLResponse)?.statusCode == 200 else { print("ici");throw ApiError.Failed }
        ///
                                                                                
        return zone
    }

}
