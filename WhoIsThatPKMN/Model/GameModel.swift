//
//  GameModel.swift
//  WhoIsThatPKMN
//
//  Created by Gus Munguia on 19/04/23.
//

import Foundation

struct  GameModel{
    
    var score: Int = 0
    
    mutating func checkAnswer(_ userAnswer:String,_ correctAnswer: String)->Bool{
        
        if userAnswer.lowercased() == correctAnswer.lowercased(){
            score += 1
            return true
        }
        
        return false
        
    }
    
    func getScore() -> Int{
        
        return score
    }
    
    
    mutating func setScore(score: Int){
        self.score = score
    }
    
}
