//
//  GameViewModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 13/03/2023.
//

import Foundation

class GameViewModel:ObservableObject {
    @Published public var _id: String
    @Published public var name: String
    @Published public var type: String
    
    init(_id: String, name: String, type: String) {
        self._id = _id
        self.name = name
        self.type = type
    }
}
