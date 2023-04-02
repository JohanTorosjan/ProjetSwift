//
//  GameListViewModel.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 13/03/2023.
//

import Foundation

class GameListViewModel:ObservableObject{
    
    //variables
    @Published public var games: [GameViewModel]
    
    //states
    @Published var uiState:GameListStates = .Init{
        didSet{
            switch uiState{
            case .Loading(let games):
                self.games=games
                print("self.games:")
                print(self.games[0].name)
            default:break
            }
        }
    }
    
    
    init(games:[GameViewModel]) {
        self.games=games
    }
    
}

enum GameListStates{
    case Init
    case Loading([GameViewModel])
    case Loaded
}

