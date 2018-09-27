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

//Example
//{
//    "message": "ok",
//    "data": [
//    {
//    "frc_idx": 12,
//    "gu_idx": 8,
//    "frc_lat": 37.5378,
//    "frc_long": 127.071
//    },
//    {
//    "frc_idx": 13,
//    "gu_idx": 8,
//    "frc_lat": 37.5378,
//    "frc_long": 127.071
//    },
//    {
//    "frc_idx": 14,
//    "gu_idx": 8,
//    "frc_lat": 37.5463,
//    "frc_long": 127.107
//    },
//    {
//    "frc_idx": 15,
//    "gu_idx": 8,
//    "frc_lat": 37.568,
//    "frc_long": 127.085
//    }
//    ]
//}
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

//Example
//{
//    "message": "OK",
//    "data": [
//    {
//    "frc_information": [
//    {
//    "frc_idx": 8,
//    "gu_idx": 18,
//    "frc_name": "우장산숲속도서관",
//    "frc_lat": 37.5484,
//    "frc_long": 126.842,
//    "frc_add": "서울특별시 강서구 화곡동 1159-4",
//    "frc_phone": "02-2696-6689",
//    "frc_salepercent": 5,
//    "frc_type": 1
//    }
//    ]
//    }
//    ]
//}
