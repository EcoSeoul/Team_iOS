//
//  MileageList.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 27..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

//EcoMileage (eco_value : 0)
struct MileageList: Codable {
    
    let status: String
    let message: String
    let mileageTotalUsage: [MileageListData]
    let usedMileage: Int
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case message = "message"
        case mileageTotalUsage = "milage_total_usage"
        case usedMileage = "used_milage"
    }
}

struct MileageListData: Codable {
    let mileageIdx: Int
    let mileageWithdraw: Int?
    let mileageDeposit: Int?
    let userIdx: Int
    let mileageDate: String
    let mileageUsage: String
    let orgIdx: Int?
    let goodsIdx: Int?
    
    enum CodingKeys: String, CodingKey{
        case mileageIdx = "mileage_idx"
        case mileageWithdraw = "mileage_withdraw"
        case mileageDeposit = "mileage_deposit"
        case userIdx = "user_idx"
        case mileageDate = "mileage_date"
        case mileageUsage = "mileage_usage"
        case orgIdx = "org_idx"
        case goodsIdx = "goods_idx"
        
    }
}


//EcoMoney (eco_value : 1)
struct MoneyList: Codable {
    let status: String
    let message: String
    let moneyTotalUsage: [MoneyListData]
    let usedMileage: Int
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case message = "message"
        case moneyTotalUsage = "milage_total_usage"
        case usedMileage = "used_milage"
    }
}

struct MoneyListData: Codable {
    let moneyIdx: Int
    let moneyWithdraw: Int?
    let moneyDeposit: Int?
    let moneyDate: String
    let userIdx: Int
    let moneyUsage: String
   
    
    enum CodingKeys: String, CodingKey{
        case moneyIdx = "money_idx"
        case moneyWithdraw = "money_withdraw"
        case moneyDeposit = "money_deposit"
        case moneyDate = "money_date"
        case userIdx = "user_idx"
        case moneyUsage = "money_usage"
      
    }
}


