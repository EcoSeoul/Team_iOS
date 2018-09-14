//
//  CircleViewElement.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//CircleGraph가 있는 뷰
//titleLabel, circleGraph, contentLabel, downBtn 으로 구성
//Animation: downBtn(Hovering)

class CircleView: UIView {
    
    var parentView: UIScrollView?
    var percentage: Double?
    
    var circleGraph: CircleGraph?

    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 94, y: 72, width: 187, height: 41))
        label.textAlignment = .center
        label.text = "전체 탄소배출량"
        label.font = UIFont(name: "NotoSansCJKkr-Regular", size: 28)
        return label
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 38, y: 508, width: 287, height: 41))
        label.textAlignment = .left
        label.text = "작년보다 20%나 절약!!"
        label.font = UIFont(name: "NotoSansCJKkr-Regular", size: 28)
        return label
    }()
    
    var contentLabel2: UILabel = {
        let label = UILabel(frame: CGRect(x: 38, y: 550, width: 287, height: 41))
        label.textAlignment = .left
        label.text = "스고이 데스요. ~_~"
        label.font = UIFont(name: "NotoSansCJKkr-Regular", size: 28)
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
        parentView.subviews.last?.addSubview(contentLabel2)
        makeCircleGraph()

    }
    
    func makeCircleGraph() {
        circleGraph = CircleGraph((parentView?.subviews.last)!, percentage!)
        circleGraph?.animateCircle()
    }
    
    
 
}



