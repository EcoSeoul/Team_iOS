//
//  CommunityView.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 27..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct CommunityView: Codable {
    
    let status: String
    let message: String
    let boardResult: [BoardResult]
    let commentResult: [CommentResult]
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case message = "message"
        case boardResult = "board_Result"
        case commentResult = "comment_Result"
    }
}

struct BoardResult: Codable {
    
    let boardIdx: Int
    let boardTitle: String
    let boardContent: String
    let boardDate: String
    let userIdx: Int
    let boardLike: Int
    let boardCmtnum: Int
    let writerCheck: Int
    
    enum CodingKeys: String, CodingKey {
        case boardIdx = "board_idx"
        case boardTitle = "board_title"
        case boardContent = "board_content"
        case boardDate = "board_date"
        case userIdx = "user_idx"
        case boardLike = "board_like"
        case boardCmtnum = "board_cmtnum"
        case writerCheck = "writer_check"
    }
}

struct CommentResult: Codable {
    let cmtIdx: Int
    let cmtContent: String
    let cmtDate: String
    let userIdx: Int
    let writerCheck: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case cmtIdx = "cmt_idx"
        case cmtContent = "cmt_content"
        case cmtDate = "cmt_date"
        case userIdx = "user_idx"
        case writerCheck = "writer_check"
        
    }
}