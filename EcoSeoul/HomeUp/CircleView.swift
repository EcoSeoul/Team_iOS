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

class CircleView: UIView {
    
    var parentView: UIScrollView?
    var percentage: Double?
    
    var circleGraph: CircleGraph?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
   init(_ parentView: UIScrollView, _ percentage: Double){
        super.init(frame: parentView.frame)
        self.parentView = parentView
        self.percentage = percentage
    
        makeCircleGraph()
    
    }
    
    func makeCircleGraph() {
        circleGraph = CircleGraph((parentView?.subviews.last)!, percentage!)
        circleGraph?.animateCircle()
    }
    
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



