//
//  GameListView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 13/03/2023.
//

import SwiftUI

struct GameListView: View {
    @ObservedObject var gameList:GameListViewModel
    private var gameListIntent:GameListIntent

    init() {
        let  gameListLoader:GameListViewModel=GameListViewModel(games:[])
        let gameListIntentLoader:GameListIntent=GameListIntent(gameList: gameListLoader)
        self.gameList=gameListLoader
        self.gameListIntent=gameListIntentLoader
    }
    var body: some View {
        
        VStack
        {
            Text("hello")
        }.onAppear{
                gameListIntent.getGames()
            }
        
        
    }
        
        struct GameListView_Previews: PreviewProvider {
            static var previews: some View {
                GameListView()
            }
        }
    }

