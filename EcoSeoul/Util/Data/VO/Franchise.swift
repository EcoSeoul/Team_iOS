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
