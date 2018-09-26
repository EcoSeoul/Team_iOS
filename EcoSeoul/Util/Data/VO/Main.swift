//
//  Main.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 26..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct MainData: Codable {
    let term: [Int]
    let carbon: [Int]
    let pastCarbon: [Int]
    let usageData: UsageData
    let userInfo: [UserInfo]
    let message: String
    
    enum CodingKeys: String, CodingKey {
     
        case term = "term"
        case carbon = "carbon"
        case pastCarbon = "pastCarbon"
        case usageData = "usageData"
        case userInfo = "userInfo"
        case message = "message"
      
    }
}



struct UsageData: Codable {
    
    let elecData : Percent
    let waterData : Percent
    let gasData: Percent
    let carbonData: Percent
    
    enum CodingKeys: String, CodingKey {
        case elecData = "elec"
        case waterData = "water"
        case gasData = "gas"
        case carbonData = "carbon"
    }
}

struct Percent: Codable {
    let updown: Int
    let percent: Int
    let past : Int
    let present: Int
    
    enum CodingKeys: String, CodingKey {
        case updown = "up_down"
        case percent = "percentage"
        case past = "past"
        case present = "present"

    }
}

struct UserInfo: Codable{
    let userBarcode: String
    let userMileage: Int
    
    enum CodingKeys: String, CodingKey {
        case userBarcode = "user_barcodenum"
        case userMileage = "user_mileage"
    }
}

//EXAMPLE
//{
//    "term": [
//    4,
//    10
//    ],
//    "carbon": [
//    {
//    "use_month_int": 220,
//    "use_carbon": 30
//    },
//    {
//    "use_month_int": 221,
//    "use_carbon": 60
//    },
//    {
//    "use_month_int": 222,
//    "use_carbon": 40
//    }
//    ],
//    "totalCarbon": 130,
//    "pastTotalCarbon": 210,
//    "usageData": {
//        "elec": {
//            "up_down": 0,
//            "percentage": 67
//        },
//        "water": {
//            "up_down": 0,
//            "percentage": 75
//        },
//        "gas": {
//            "up_down": 0,
//            "percentage": 60
//        },
//        "carbon": {
//            "up_down": 1,
//            "percentage": 62
//        }
//    },
//    "userInfo": [
//    {
//    "user_barcodenum": "2312323",
//    "user_mileage": 20000
//    }
//    ],
//    "message": "Successfully Get Data"
//}
