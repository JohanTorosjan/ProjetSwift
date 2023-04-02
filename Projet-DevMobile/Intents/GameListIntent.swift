//
//  GameListIntent.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 13/03/2023.
//

import Foundation
import SwiftUI

struct GameListIntent{
    /*
    private let apiUrl=URL(string:"https://fine-pink-lab-coat.cyclic.app/jeux")
    var urlResquest:URLRequest
     */
    
    @ObservedObject var gameList:GameListViewModel
    
    
    @State var games:[GameViewModel]=[]
    private var gameDAO:GameDAO=GameDAO()
    
    
    
    init(gameList: GameListViewModel) {
        self.gameList = gameList
        }
    
    
    
     func getGames(){
         let gameDAO:GameDAO=GameDAO()
         
         Task{
             guard let data = try? await gameDAO.loadDatas() else{return};
             self.gameList.uiState = .Loading(data)
         }
         
         

         /*
         let gameDAO:GameDAO=GameDAO()
         gameDAO.loadDatas{result in
             switch result{
             case .success(let games):
                 print(games[0].name)
                 //self.games=games
                 self.gameList.uiState = .Loading(games)
             case .failure(let error):
                 print(error)
             default:
                 break
             }
             
         }
         self.gameList.uiState = .Loading(games)
          */
        
    }

    /*
    func loadDatas(){
        debugPrint("OUI")
        let dataTask=URLSession.shared.dataTask(with: urlResquest){
            (data,response,error) in
            if let error=error{
                print("ERROR: ",error)
                return
            }
            debugPrint("OUIII")
            
            
            //guard let response=response as? HTTPURLResponse else{print("HERE");return}
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                do{
                    debugPrint("ici")
                    let decoder = JSONDecoder() // création d'un décodeur
                    let decoded = try? decoder.decode([GameDTO].self, from:data)
                    guard let decodedDatas=decoded else{return}
                    self.games=decodedDatas
                    print(self.games)
                }
                
                catch let error{
                    debugPrint("ERROR",error)
                }
            }
            
            /*
             let decoder = JSONDecoder() // création d'un décodeur
             if let decoded = try? decoder.decode([GameDTO].self, from:
             data) { // si on a réussit à décoder
             print(decoded)
             }
             /////
             */
             }
             
            dataTask.resume()
        }
        
        
        */
    }

