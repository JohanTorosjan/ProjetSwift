//
//  FestivalListIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 18/03/2023.
//

import Foundation
import SwiftUI

class FestivalListIntent{
    @ObservedObject var festivalList:FestivalListModel
    
    
    init(festivalList: FestivalListModel) {
        self.festivalList = festivalList
    }
    
    func getFestivalList(){
    let festivalListDAO:FestivalListDAO=FestivalListDAO()
        Task{
            guard let data = try? await festivalListDAO.getAll() else{print("nan");return};
            self.festivalList.uiState = .Loading(data)
        }
    }

          
}
