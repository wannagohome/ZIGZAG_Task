//
//  StructsAndEnums.swift
//  Shop-List-Filter
//
//  Created by Peter Jang on 03/04/2019.
//  Copyright © 2019 Peter Jang. All rights reserved.
//

import UIKit

struct Shop {
    enum Style: String, CaseIterable {
        case Feminine = "페미닌"
        case Modernchic = "모던시크"
        case SimpleBasic = "심플베이직"
        case Lovly = "러블리"
        case Unique = "유니크"
        case MissyStyle = "미시스타일"
        case CampusLook = "캠퍼스룩"
        case Vintage = "빈티지"
        case SexyGlam = "섹시글램"
        case SchoolLook = "스쿨룩"
        case Romantic = "로맨틱"
        case OfficeLook = "오피스룩"
        case Luxury = "럭셔리"
        case HollyWood = "헐리웃스타일"
        
        func getColor() -> UIColor {
            switch self {
            case .Feminine: return UIColor.rgb(red: 242, green: 200, blue: 251)
            case .Modernchic: return UIColor.rgb(red: 240, green: 240, blue: 240)
            case .SimpleBasic: return UIColor.rgb(red: 252, green: 236, blue: 186)
            case .Lovly: return UIColor.rgb(red: 247, green: 205, blue: 231)
            case .Unique: return UIColor.rgb(red: 237, green: 229, blue: 245)
            case .MissyStyle: return UIColor.rgb(red: 248, green: 235, blue: 213)
            case .CampusLook: return UIColor.rgb(red: 238, green: 240, blue: 248)
            case .Vintage: return UIColor.rgb(red: 235, green: 227, blue: 218)
            case .SexyGlam: return UIColor.rgb(red: 247, green: 205, blue: 204)
            case .SchoolLook: return UIColor.rgb(red: 236, green: 254, blue: 216)
            case .Romantic: return UIColor.rgb(red: 254, green: 252, blue: 194)
            case .OfficeLook: return UIColor.rgb(red: 234, green: 243, blue: 254)
            case .Luxury: return UIColor.rgb(red: 233, green: 211, blue: 189)
            case .HollyWood: return UIColor.rgb(red: 235, green: 250, blue: 254)
            }
        }
    }
    
    enum AgeGroup: String {
        case Teen = "10대"
        case Twenty = "20대"
        case Thirty = "30대"
    }
    
    var styles: [Style] = []
    var ageGroup: [AgeGroup] = []
}


enum Login: Int {
    case noId = 1
    case noPassword = 2
    case noAgreement = 3
    case available = 4
}
