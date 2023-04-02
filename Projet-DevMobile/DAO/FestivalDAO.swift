//
//  FestivalDAO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 20/03/2023.
//

import Foundation
import SwiftUI
class FestivalDAO{
    
    private var apiUrl:URL
    
    init() {
        guard let apiUrl=URL(string:"http://localhost:3000/festival") else{
            fatalError("Missing URL")
        }
        self.apiUrl = apiUrl
    }
    
    func update(festival:FestivalModel) async throws -> FestivalModel{
        /*
        
        guard let putUrl:URL = URL(string:self.apiUrl.absoluteString+"/"+festival.id) else{fatalError("Missing URL")}
        
        
        /// TODO
        var updatedFestival:FestivalModel=FestivalModel(id: "", nom: "", annee: "", jourDeFestival: [])
        /// RETURN VRAI FESTIVAL 
        
        var festivalDTO:FestivalDTO=FestivalDTO(_id: festival.id, nom: festival.nom, annee: festival.annee)
        guard let encoded=try? JSONEncoder().encode(festivalDTO) else{print("pas encoded");return updatedFestival}
        
        var urlResquest:URLRequest=URLRequest(url:putUrl)
      
        urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlResquest.httpMethod="PUT"
        do{
            let(data,_)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
            print(data)
        }
        catch{
            throw ApiError.Failed
        }
         */
        return festival
        
    }
    
    /*
    func addZone(festival:FestivalModel,zone:ZoneModel) async throw -> [ZoneModel]{
       
        guard let putUrl:URL = URL(string:self.apiUrl.absoluteString+"/addZone/"+festival.id) else{fatalError("Missing URL")}
        var zoneDTO:ZoneDTO = ZoneDTO(nom: zone.nom, nombreBenevolesNecessaire: zone.nbrvol)
        guard let encoded=try? JSONEncoder().encode(festivalDTO) else{print("pas encoded");return updatedFestival}
        
        var urlResquest:URLRequest=URLRequest(url:putUrl)
      
        urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlResquest.httpMethod="PUT"
        do{
            let(data,_)=try await URLSession.shared.upload(for: urlResquest, from: encoded)
            print(data)
        }
        catch{
            throw ApiError.Failed
       
         }
     
    
    }
     */
    
    
    
    func getZones(festival:FestivalModel) async throws -> [ZoneModel]{
        let decoder = JSONDecoder() // création d'un décodeur
       
        guard let getUrl:URL = URL(string:self.apiUrl.absoluteString+"/zones/"+festival.id) else{fatalError("Missing URL")}
        var zones:[ZoneModel]=[]
        let urlResquest:URLRequest=URLRequest(url:getUrl)
        let (data,response) = try await URLSession.shared.data(for: urlResquest)
       
        guard(response as? HTTPURLResponse)?.statusCode == 200 else {
            /// ajout de la freezone
            guard let freeZoneUrl:URL = URL(string:"http://localhost:3000/zone/single/FreeZone") else{fatalError("Missing URL")}
            let freeZoneResquest:URLRequest=URLRequest(url:freeZoneUrl)
            let (freeZonedata,_) = try await URLSession.shared.data(for: freeZoneResquest)
            let freeZonedecoded = try? decoder.decode(ZoneDTO.self,from:freeZonedata)
            guard let freezoneDTO=freeZonedecoded else{print("non");return zones}
            
            let freezone:ZoneModel = ZoneModel(id: freezoneDTO._id, nom: freezoneDTO.nom , nbrvol: freezoneDTO.nombreBenevolesNecessaire)
            zones.append(freezone)
            return zones
            ///
        }
    
       
        let decoded = try? decoder.decode([ZoneDTO].self,from:data)
        guard let zoneDTO=decoded else{print("non");return zones}
        
        
      
        /*
        guard let freeZoneUrl:URL = URL(string:"http://localhost:3000/zone/single/FreeZone") else{fatalError("Missing URL")}
        let freeZoneResquest:URLRequest=URLRequest(url:freeZoneUrl)
        let (freeZonedata,_) = try await URLSession.shared.data(for: freeZoneResquest)
        let freeZonedecoded = try? decoder.decode(ZoneDTO.self,from:freeZonedata)
        guard let freezoneDTO=freeZonedecoded else{print("non");return zones}
        
        let freezone:ZoneModel = ZoneModel(id: freezoneDTO._id, nom: freezoneDTO.nom , nbrvol: freezoneDTO.nombreBenevolesNecessaire)
        zones[0]=freezone
        */
        
        
        
        
        for i in 0...zoneDTO.count-1{
            let zone:ZoneModel=ZoneModel(id:zoneDTO[i]._id ,nom: zoneDTO[i].nom, nbrvol: zoneDTO[i].nombreBenevolesNecessaire)
            print(zone.nom)
            print(zone.nbrvol)
                zones.append(zone)
        }
        
        return zones
    }
    
    
    func create(nom:String,annee:Int,zones:[ZoneModel]) async throws ->String{

        var urlResquest:URLRequest=URLRequest(url:apiUrl)
        var festivalDTO:CreateFestivalDTO = CreateFestivalDTO(nom: nom, annee: annee)
        guard let encoded=try? JSONEncoder().encode(festivalDTO) else{print("pas encoded");throw ApiError.Failed}
        urlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlResquest.httpMethod="POST"

        let(data,response)=try await URLSession.shared.upload(for: urlResquest, from: encoded)

        let decoded = try? JSONDecoder().decode(FestivalDTO.self,from:data)
        guard let newfestivalDTO=decoded else{print("non");return "faillure"}
        
        
        ///
        let festivalid:String = newfestivalDTO._id
        guard let zoneURL:URL = URL(string:self.apiUrl.absoluteString+"/addZone/"+festivalid) else{fatalError("Missing URL")}
        var zoneUrlResquest:URLRequest=URLRequest(url:zoneURL)
        zoneUrlResquest.setValue("application/json", forHTTPHeaderField: "Content-type")
        zoneUrlResquest.httpMethod="PUT"
       
       
        let zone:ZoneModel = zones[0]
        var zoneDTO:ZoneDTO = ZoneDTO(_id: zone.id, nom: zone.nom, nombreBenevolesNecessaire: zone.nbrvol)
        guard let zoneencoded=try? JSONEncoder().encode(zoneDTO) else{print("pas encoded");throw ApiError.Failed}
        let(dataZone,responseZone)=try await URLSession.shared.upload(for: zoneUrlResquest, from: zoneencoded)
        guard(responseZone as? HTTPURLResponse)?.statusCode == 200 else { print("ici");throw ApiError.Failed }
        ///
                                                                                
        print("ok")
        
        return "success"
            /*
            let decoder = JSONDecoder() // création d'un décodeur
            let decoded = try? decoder.decode(FestivalDTO.self,from:data)
            guard let newFestival=decoded else{print("non"); throw ApiError.Failed}
            festival=FestivalModel(id: newFestival._id, nom: newFestival.nom, annee: newFestival.annee, jourDeFestival: [], zone: [])
            print(festival.nom)
            return festival
        }
        catch{
            throw ApiError.Failed
        }
        
        
        */
           
    }
    
    
    func addDay(festivalId:String,festivalDay:JourDeFestivalModel) async throws -> String{
        guard let putURL:URL = URL(string:self.apiUrl.absoluteString+"/addJour/"+festivalId) else{fatalError("Missing URL")}
        var UrlRequest:URLRequest=URLRequest(url:putURL)
        UrlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        UrlRequest.httpMethod="PUT"
        let festivalDayDTO:JourDeFestivalDTO = JourDeFestivalDTO(_id: festivalDay.id, nom: "", begining: "", ending: "")
        guard let encoded=try? JSONEncoder().encode(festivalDayDTO) else{print("pas encoded");throw ApiError.Failed}
        let(data,response)=try await URLSession.shared.upload(for: UrlRequest, from: encoded)
        guard(response as? HTTPURLResponse)?.statusCode == 200 else { print("ici");throw ApiError.Failed }
        return "ok"
    }
    
    
    func associateZone(festival:FestivalModel) async throws -> String {
        guard let putURL:URL = URL(string:"http://localhost:3000/event/associateZone/"+festival.id) else{fatalError("Missing URL")}
        var UrlRequest:URLRequest=URLRequest(url:putURL)
        UrlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        UrlRequest.httpMethod="PUT"
        var festivalDTO:CreateFestivalDTO = CreateFestivalDTO(nom: "", annee: 0)
        guard let encoded=try? JSONEncoder().encode(festivalDTO) else{print("pas encoded");throw ApiError.Failed}
        let(data,response)=try await URLSession.shared.upload(for: UrlRequest, from: encoded)
        guard(response as? HTTPURLResponse)?.statusCode == 200 else { print("ici");throw ApiError.Failed }
        return "success"
    }
}
