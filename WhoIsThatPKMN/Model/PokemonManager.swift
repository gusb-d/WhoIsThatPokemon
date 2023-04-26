//
//  PokemonManager.swift
//  WhoIsThatPKMN
//
//  Created by Gus Munguia on 19/04/23.
//

import Foundation

protocol PokemonManagerDelegate{
    
    func didUpdatePokemon(pokemons:[PokemonModel])
    func didFailWithError(error:Error)
    
}



struct PokemonManager{
    let pokemonURL:String = "https://pokeapi.co/api/v2/pokemon?limit=898"
    var delegate:PokemonManagerDelegate?
    
    func fetchPokemon(){
            
        preformRequest(with: pokemonURL)
        
    }
    
    
    private func preformRequest(with urlString:String){
        //        1.- Create/get url
        //        if let helps to avoid errors on the code
        if let url = URL(string: urlString){
            //        2.- Create URL Session
            
            let session = URLSession(configuration: .default)
            //            3.- Give the session a task
            let task = session.dataTask(with: url){data,response,error in
                
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                }
                else{
                    
                    if let safeData = data{
                        
                        if let pokemon = self.parseJSON(pokemonData:safeData){
                            
                            self.delegate?.didUpdatePokemon(pokemons: pokemon)
                        }
                        
                        
                        
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
    }
    
    
    
    
     private func parseJSON(pokemonData:Data) ->[PokemonModel]?{
        let decoder = JSONDecoder()
        
        do{
            
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodeData.results?.map{
                PokemonModel(name: $0.name ?? "", imageUrl: $0.url ?? "")
            }
            
            return pokemon
            
        }catch{
            return nil
        }
    }
}
