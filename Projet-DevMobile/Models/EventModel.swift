//
//  EventModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI

class EventModel:ObservableObject,Identifiable{
    @Published public var beginingdate:Date
    @Published public var endingdate:Date
    @Published public var zone:ZoneModel
    @Published public var benevoles:[BenevoleModel]
    
    init(beginingdate: Date, endingdate: Date, zone: ZoneModel, benevoles: [BenevoleModel]) {
        self.beginingdate = beginingdate
        self.endingdate = endingdate
        self.zone = zone
        self.benevoles = benevoles
    }
}
