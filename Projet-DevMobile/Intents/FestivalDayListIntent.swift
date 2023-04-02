//
//  FestivalDayListIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 20/03/2023.
//


import Foundation
import SwiftUI

class FestivalDayListIntent{
   
    @ObservedObject var festivalDays:FestivalDayListModel
    
    
    init(festivalDays: FestivalDayListModel) {
        self.festivalDays = festivalDays
    }
    
    func getFestivalDays(festival:FestivalModel){
        
    let festivalDaysDAO:FestivalDayListDAO=FestivalDayListDAO()
        Task{
            guard let data = try? await festivalDaysDAO.getAll(festival:festival) else{print("nan");return};
            self.festivalDays.uiState = .Loading(data)
        }
    }
    
    func addDay(festival:FestivalModel, name:String, beginingDate:Date, endingDate:Date){

        /*
        var ending:Date = endingDate
        
        let calendar = Calendar.current
        let dayComponent = calendar.component(.day, from: beginingDate)
        ending = calendar.date(bySetting: .day, value: dayComponent, of: ending)!
        */
        
        

        let festivalDayDAO:FestivalDayListDAO = FestivalDayListDAO()
        let festivalDAO:FestivalDAO = FestivalDAO();
        let festivalDay:JourDeFestivalModel = JourDeFestivalModel(id: "", nom: name, beginingdate: beginingDate, endingdate: endingDate, creneaux: [])
        
       Task{
           guard let newDay = try? await festivalDayDAO.create(festivalDay:festivalDay, festival: festival) else{print("nan");return};
           guard let data = try? await festivalDAO.addDay(festivalId:festival.id,festivalDay:newDay) else{print("nan");return};
           guard let success = try? await festivalDAO.associateZone(festival:festival) else{print("nan");return};
          
           self.festivalDays.uiState = .AddOne(newDay)
       }
    }
    
    


          
}
