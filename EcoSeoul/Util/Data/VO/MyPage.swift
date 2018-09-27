//
//  MyPage.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 27..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct MyPage: Codable {
    
    let status: String
    let message: String
    let result: [MyPageData]
    
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
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
