//
//  ImageData.swift
//  WhoIsThatPKMN
//
//  Created by Gus Munguia on 19/04/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation



// MARK: - Welcome
struct ImageData:Codable {

    let sprites: Sprites?
 
}


// MARK: - Sprites
class Sprites:Codable {
   
    let other: Other?
   

    init(other: Other?) {
     
        self.other = other
 
    }
}

// MARK: - Other
struct Other:Codable {
  
    let officialArtwork: OfficialArtwork?
    
    enum CodingKeys:String,CodingKey{
        case officialArtwork = "official-artwork"
    }
}



// MARK: - OfficialArtwork
struct OfficialArtwork:Codable {
    let frontDefault: String?
    
    enum CodingKeys:String,CodingKey{
        case frontDefault="front_default"
    }
}

