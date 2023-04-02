//
//  FestivalDayIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 20/03/2023.
//

import Foundation
import SwiftUI

class FestivalDayIntent{
    
    @ObservedObject var festivalDay:JourDeFestivalModel
    
    init(festivalDay: JourDeFestivalModel) {
        self.festivalDay = festivalDay
    }
    
    func update(nom:String,beginingdate:Date,endingdate:Date){
        print(beginingdate)
    }
}
