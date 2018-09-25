//
//  LoginVO.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 25..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//
import Foundation

struct LoginVO: Codable {
    
    let status : Bool
    let message: String
    let userIdx : Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case userIdx = "user_idx"
    }
    
}



