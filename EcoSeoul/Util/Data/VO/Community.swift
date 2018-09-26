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
    let data: [CommunityData]
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case data = "data"
        
    }
}

struct CommunityData: Codable {
    let bestList: [List]?
    let allList: [List]?
    
    enum CodingKeys: String, CodingKey{
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
    let boardLike: Int
    let boardCmtnum: Int
    let userName: String
    
    enum CodingKeys:String, CodingKey {
        case boardIdx = "board_idx"
        case boardTitle = "board_title"
        case boardContent = "board_content"
        case boardDate = "board_date"
        case userIdx = "user_idx"
        case boardLike = "board_like"
        case boardCmtnum = "board_cmtnum"
        case userName = "User_name"
    }
}

//struct AllList: Codable {
//    let boardIdxA: Int
//    let boardTitleA: String
//    let boardContentA: String
//    let boardDateA: String
//    let userIdxA: Int
//    let boardLikeA: Int
//    let boardCmtnumA: Int
//    let userNameA: String
//
//    enum CodingKeys:String, CodingKey {
//        case boardIdxA = "board_idx"
//        case boardTitleA = "board_title"
//        case boardContentA = "board_content"
//        case boardDateA = "board_date"
//        case userIdxA = "user_idx"
//        case boardLikeA = "board_like"
//        case boardCmtnumA = "board_cmtnum"
//        case userNameA = "User_name"
//    }
//}
//
