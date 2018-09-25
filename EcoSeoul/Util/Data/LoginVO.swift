//
//  LoginVO.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 25..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//
import Foundation

struct LoginVO: Codable {
    
    let userIdx : Int?
    let userID: String
    let userPW: String
    let userName: String
    let userBarcodeNum: String
    let userMileage: Int
    let userMoney: Int
    let userJoinDate: String
    

    enum CodingKeys: String, CodingKey {
        case userIdx = "user_idx"
        case userID = "user_ID"
        case userPW = "user_pw"
        case userName = "user_name"
        case userBarcodeNum = "user_barcodenum"
        case userMileage = "user_mileage"
        case userMoney = "user_money"
        case userJoinDate = "user_join_date"
    }
    
}



