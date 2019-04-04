//
//  AlterDateFormat.swift
//  ZIGZAG_task (bowling-score-calculator)
//
//  Created by Peter Jang on 01/04/2019.
//  Copyright © 2019 Peter Jang. All rights reserved.
//

import Foundation


func solve(timeString: String, N: Int) -> String {
    
    var time: Time = fetchTime(time: timeString)
    
    time.sec += N
    
    let timeConverted: String = String(format: "%02d:%02d:%02d", time.hour24, time.min, time.sec)
    let answer: String = "| \(timeString) | \(N) | \(timeConverted) |"
    return answer
    
}


struct Time {
    init(ampm :String, hour: Int, min: Int, sec: Int) {
        self.ampm = ampm
        self.hour12 = hour
        self.min = min
        self.sec = sec
        
        if(ampm == "AM"){
            if(hour == 12) { hour24 = 0 }
            else { hour24 = hour12 }
        } else {
            if(hour == 12) { hour24 = 12 }
            else { hour24 = hour12 + 12 }
        }
        
    }
    
    var ampm: String
    var hour12: Int
    var hour24: Int {
        didSet {
            hour24 %= 24
        }
    }
    var min: Int {
        didSet {
            hour24 += min / 60
            min %= 60
        }
    }
    var sec: Int {
        didSet {
            min += sec / 60
            sec %= 60
        }
    }
}


func fetchTime(time: String) -> Time {
    let ampm = time.components(separatedBy: " ")
    let timeNumbers = ampm[1].components(separatedBy: ":")
        .compactMap{Int($0)}.prefix(3)
    let timeStruct = Time(ampm: ampm[0], hour: timeNumbers[0], min: timeNumbers[1], sec: timeNumbers[2])
    
    return timeStruct
}
