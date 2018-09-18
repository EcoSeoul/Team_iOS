//
//  CircleViewElement.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//CircleGraph가 있는 뷰
//titleLabel, circleGraph, contentLabel 으로 구성


class CircleView: UIView {
    
    var parentView: UIScrollView?
    var percentage: Double?
    
    var circleGraph: CircleGraph?

    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 94, y: 78, width: 187, height: 41))
        label.textAlignment = .center
        label.text = "전체 탄소배출량"
        label.font = UIFont(name: notoSansFont.Regular.rawValue, size: 28)
        return label
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 23, y: 430, width: 287, height: 82))
        label.textAlignment = .left
        label.text = "작년보다 10%를 \n절약한 당신! 최고에요!"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        label.font = UIFont(name: notoSansFont.Regular.rawValue, size: 27)
        label.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return label
    }()
    
    
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
        parentView.subviews.last?.addSubview(titleLabel)
        parentView.subviews.last?.addSubview(contentLabel)
        makeCircleGraph()

    }
    
    func makeCircleGraph() {
        circleGraph = CircleGraph((parentView?.subviews.last)!, percentage!)
        circleGraph?.animateCircle()
    }
    
    func animateView() {
        circleGraph?.animateCircle()
    }
 
}



