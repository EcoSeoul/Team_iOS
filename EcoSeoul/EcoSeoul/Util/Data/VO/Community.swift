//
//  Community.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 26..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct Community: Codable {
    
    let message: String
    let bestList: [List]?
    let allList: [List]?
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case bestList = "best_list"
        case allList = "all_list"
        
    }
}

struct List: Codable {
    let boardIdx: Int
    let boardTitle: String
    let boardContent: String
    let boardDate: String
    let userIdx: Int
    let boardLike: Int?
    let boardCmtnum: Int?
    let userName: String
    let likeFlag: Bool
    
    enum CodingKeys:String, CodingKey {
        case boardIdx = "board_idx"
        case boardTitle = "board_title"
        case boardContent = "board_content"
        case boardDate = "board_date"
        case userIdx = "user_idx"
        case boardLike = "board_like"
        case boardCmtnum = "board_cmtnum"
        case userName = "User_name"
        case likeFlag = "likeFlag"
    }
}

