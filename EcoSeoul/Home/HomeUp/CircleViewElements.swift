//
//  CircleViewElement.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import UIKit

//CircleGraph가 있는 뷰의 요소들
//titleLabel, co2Label, durationLabel, percentageLabel, bottomLabel
//updownImage, downButton, homeAllButton

class CircleView {
    
   
    
    //퍼센트 레이블
    var percentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        guard let customFont = UIFont(name: "NotoSansCJKkr-Regular", size: UIFont.systemFontSize) else
        {
            fatalError("error!!!")
        }
        label.font = UIFontMetrics.default.scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
}
