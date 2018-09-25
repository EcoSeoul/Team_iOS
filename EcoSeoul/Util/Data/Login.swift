//
//  LoginData.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 25..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

//{
//"message": "Login Success",
//"checkResult": [
//{
//"user_idx": 1,
//"user_ID": "timi",
//"user_pw": "123",
//"user_name": "timti",
//"user_barcodenum": "2312323",
//"user_mileage": 20000,
//"user_money": 10000,
//"user_join_date": "2018-01-23T00:00:00.000Z"
//}
//]
//}

import Foundation

struct LoginData: Codable {
//    let status : Bool
    let message: String
    let checkResult : [Login]
    
    enum CodingKeys: String, CodingKey {
//        case status = "status"
        case message = "message"
        case checkResult = "checkResult"
    }
}

struct Login: Codable {
    let userIdx : Int
    let userId: String
    let userPw: String
    let userName: String
    let userBarcodeNum: String
    let userMileage: Int
    let userMoney: Int
    let userJoinDate: String
    
    enum CodingKeys: String, CodingKey {
        case userIdx = "user_idx"
        case userId = "user_ID"
        case userPw = "user_pw"
        case userName = "user_name"
        case userBarcodeNum = "user_barcodenum"
        case userMileage = "user_mileage"
        case userMoney = "user_money"
        case userJoinDate = "user_join_date"
    }
    
}

