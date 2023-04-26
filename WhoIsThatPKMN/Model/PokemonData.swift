//
//  PokemonData.swift
//  WhoIsThatPKMN
//
//  Created by Gus Munguia on 19/04/23.
//

import Foundation


struct PokemonData:Codable{
    
    let results:[Result]?
    
    
}

struct Result:Codable{
    
    let name:String?
    let url:String?
}
