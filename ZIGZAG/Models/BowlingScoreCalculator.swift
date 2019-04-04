//
//  BowlingScoreCalculator.swift
//  ZIGZAG_task (bowling-score-calculator)
//
//  Created by Peter Jang on 01/04/2019.
//  Copyright © 2019 Peter Jang. All rights reserved.
//

import Foundation

class Bowling {
    var fallenPins: [Int] = []
    var totalScore: [Int] = []
    var input: String = ""
    
    init() {}
    
    init(input: String) {
        for char in input {
            if char == "A" {
                fallenPins.append(10)
            } else {
                fallenPins.append(Int(String(char))!)
            }
        }
    }
    
    func calculateForTest() -> [Int] {
        var index: Int = 0
        var score: Int = 0
        for _ in 0 ..< 10 {
            let isIndexNextExist = fallenPins.indices.contains(index+1)
            let isIndexAfterNextExist = fallenPins.indices.contains(index+2)
            
            if index >= fallenPins.count { break }
            
            if isStrike(index)  {
                if isIndexAfterNextExist == false { break }
                
                score += 10 + fallenPins[index+1] + fallenPins[index+2]
                index += 1
                totalScore.append(score)
            } else if isSpare(index)  {
                if isIndexAfterNextExist == false { break }
                
                score += 10 + fallenPins[index+2]
                index += 2
                totalScore.append(score)
            } else {
                if isIndexNextExist == false { break }
                if fallenPins[index] + fallenPins[index+1] > 10 { return [-1] }
                
                score += fallenPins[index+1] + fallenPins[index]
                index += 2
                totalScore.append(score)
            }
            
        }
        return totalScore
    }
    
    func calculate() -> String {
        var index: Int = 0
        var score: Int = 0
        for _ in 0 ..< 10 {
            let isIndexNextExist = fallenPins.indices.contains(index+1)
            let isIndexAfterNextExist = fallenPins.indices.contains(index+2)
            
            if index >= fallenPins.count { break }
            
            if isStrike(index)  {
                if isIndexAfterNextExist == false { break }
                
                score += 10 + fallenPins[index+1] + fallenPins[index+2]
                index += 1
                totalScore.append(score)
            } else if isSpare(index)  {
                if isIndexAfterNextExist == false { break }
                
                score += 10 + fallenPins[index+2]
                index += 2
                totalScore.append(score)
            } else {
                if isIndexNextExist == false { break }
                if fallenPins[index] + fallenPins[index+1] > 10 { return "Error" }
                
                score += fallenPins[index+1] + fallenPins[index]
                index += 2
                totalScore.append(score)
            }
        }
        
        let answer: String = "| \(input) | \(totalScore) |"
        return answer
    }
    
    private func isStrike(_ index: Int) -> Bool {
        return fallenPins[index] == 10
    }
    
    private func isSpare(_ index: Int) -> Bool {
        if fallenPins.indices.contains(index+1) {
            return fallenPins[index] + fallenPins[index+1] == 10
        } else {
            return false
        }
    }
    
}
