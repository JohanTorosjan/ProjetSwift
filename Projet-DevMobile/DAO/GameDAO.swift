//
//  GameDAO.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 14/03/2023.
//

import Foundation
import SwiftUI
class GameDAO:ObservableObject{
    
    private let apiUrl=URL(string:"https://fine-pink-lab-coat.cyclic.app/jeux")
    var urlResquest:URLRequest
    
    @State var games:[GameViewModel]=[]
    
    init() {
        guard let apiUrl=URL(string:"https://fine-pink-lab-coat.cyclic.app/jeux") else{
            fatalError("Missing URL")
        }
        self.urlResquest=URLRequest(url:apiUrl)
    }
    
    
    
    func loadDatas() async throws -> [GameViewModel]{
        var games:[GameViewModel]=[]
        
        let (data,response) = try await URLSession.shared.data(for: urlResquest)
        guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.fatal }
        let decoder = JSONDecoder() // création d'un décodeur
        let decoded = try? decoder.decode([GameDTO].self,from:data)
        guard let gamesDto=decoded else{return games}
        for i in 0...gamesDto.count-1{
            let game:GameViewModel=GameViewModel(_id: gamesDto[i]._id, name: gamesDto[i].nom, type: gamesDto[i].type)
            games.append(game)
        }
        return games
    }
    enum FetchError:Error{
        case fatal
    }
        /*
        let dataTask = URLSession.shared.dataTask(with: urlResquest){(data,response,error) in
            if let error=error{
                print("ERROR: ",error)
                return
            }
            guard let data = data else { return }
            do{
                //var games:[GameViewModel]=[]
                debugPrint("ici")
                let decoder = JSONDecoder() // création d'un décodeur
                let decoded = try? decoder.decode([GameDTO].self,from:data)
                guard let gamesDto=decoded else{return}
                for i in 0...gamesDto.count-1{
                    var game:GameViewModel=GameViewModel(_id: gamesDto[i]._id, name: gamesDto[i].nom, type: gamesDto[i].type)
                    print(game.name)
                    self.games.append(game)
                }
                
            }
            
        }
        
        await dataTask.resume()
        //dataTask.resume()
        print(self.games)
        return self.games
    }

 
    func loadDatas(completion:@escaping(Result<[GameViewModel], Error>) -> Void){
        var gamesDto:[GameDTO]?
       
        let dataTask=URLSession.shared.dataTask(with: urlResquest){
            (data,response,error) in
            if let error=error{
                print("ERROR: ",error)
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                do{
                    var games:[GameViewModel]=[]
                    debugPrint("ici")
                    let decoder = JSONDecoder() // création d'un décodeur
                    let decoded = try? decoder.decode([GameDTO].self,from:data)
                    guard let gamesDto=decoded else{return}
                    
                    
                    for i in 0...gamesDto.count-1{
                        var game:GameViewModel=GameViewModel(_id: gamesDto[i]._id, name: gamesDto[i].nom, type: gamesDto[i].type)
                        games.append(game)
                    }
                
                    completion(.success(games))
          
                     let decoded = try? decoder.decode([GameDTO].self, from:data)
                     guard let gamesDto=decoded else{return}
                     //gamesDto = decodedDatas
                     print(gamesDto)
                  
                }
                catch let error{
                    debugPrint("ERROR: ",error)
                    completion(.failure(error))
                }
            }
        
            
           
             let decoder = JSONDecoder() // création d'un décodeur
             if let decoded = try? decoder.decode([GameDTO].self, from:
             data) { // si on a réussit à décoder
             print(decoded)
             }
             /////
    
        
             }
             
            dataTask.resume()
       // return [GameViewModel(_id: "aa", name: "abb", type: "bbb")]
        }
        
    func getGames(){
        loadDatas{result in
            switch result{
            case .success(let games):
                print(games[0].name)
              
            case .failure(let error):
                print(error)
            default:
                break
            }
            
        }

    }
    
***/
    
}
