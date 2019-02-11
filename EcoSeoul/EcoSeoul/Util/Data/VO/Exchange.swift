//
//  Exchange.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct Exchange: Codable {
    let message: String
    
    enum CodingKeys: String, CodingKey{
        case message = "message"

    }
}


