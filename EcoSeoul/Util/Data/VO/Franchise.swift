//
//  Franchise.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 27..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//


import Foundation

struct Franchise: Codable {
    let message: String
    let data: [FranchiseData]
    
    enum CodingKeys: String, CodingKey{
        case message = "message"
        case data = "data"
    }
    
}

struct FranchiseData: Codable {
    
    let frcIdx: Int
    let guIdx: Int
    let frcLat: Double
    let frcLong: Double
   
    
    enum CodingKeys: String, CodingKey{
        case frcIdx = "frc_idx"
        case guIdx = "gu_idx"
        case frcLat = "frc_lat"
        case frcLong = "frc_long"
  
    }
}
//=====================================================

struct FranchiseDetail: Codable {
    let message: String
    let data: [FranchiseInform]
    
    enum CodingKeys: String, CodingKey{
        case message = "message"
        case data = "data"
    }
}

struct FranchiseInform: Codable {
    let frcInfo: [FranchiseDetailData]
    enum CodingKeys: String, CodingKey{
        case frcInfo = "frc_information"
    }
}

struct FranchiseDetailData: Codable {

    let frcIdx: Int
    let guIdx: Int
    let frcName: String
    let frcLat: Double
    let frcLong: Double
    let frcAdd: String
    let frcPhone: String
    let frcSale: Int
    let frcType: Int
    
    
    enum CodingKeys: String, CodingKey{
        
        case frcIdx = "frc_idx"
        case guIdx = "gu_idx"
        case frcName = "frc_name"
        case frcLat = "frc_lat"
        case frcLong = "frc_long"
        case frcAdd = "frc_add"
        case frcPhone = "frc_phone"
        case frcSale = "frc_salepercent"
        case frcType = "frc_type"
        
    }
}
