//
//  MyPage.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 27..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct MyPage: Codable {
    
    let message: String
    let result: [MyPageData]
    
    enum CodingKeys: String, CodingKey{
        case message = "message"
        case result = "result"
    }
    
}

struct MyPageData: Codable {
    
    let userIdx: Int
    let userMileage: Int
    let userMoney: Int
    
    enum CodingKeys: String, CodingKey{
        case userIdx = "user_idx"
        case userMileage = "user_mileage"
        case userMoney = "user_money"
    }
    
    
}

//Example
//{
//    "message": "Successfully select data",
//    "result": [
//    {
//    "user_idx": 1,
//    "user_mileage": 20000,
//    "user_money": 10000
//    }
//    ]
//}
