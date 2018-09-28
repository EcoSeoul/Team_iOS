//
//  DonationView.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//mainImageView, typeImageView, titleLable
//explainTextView, selectBtn, donateBtn 로 구성
//monthLabel, titleLabel, dataLbel

class DonationView: UIView{
    
    //이니셜라이저 변수
    var parentView: UIScrollView?
    
    //메인 이미지뷰
    var mainImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 305))
        return imageView
    }()
    
    //타입 이미지
    var typeImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 316, width: 35, height: 35))
        return imageView
    }()
    
    //타이틀 레이블
    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 59, y: 320, width: 203, height: 25))
        label.textAlignment = .left
        label.font = UIFont(name: notoSansFont.Medium.rawValue, size: 17)
        label.textColor = #colorLiteral(red: 0.2651461363, green: 0.2651531994, blue: 0.2651493847, alpha: 1)
        return label
    }()
    
    //설명 레이블
    var explainTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 20, y: 359, width: 335, height: 129))
        textView.textAlignment = .left
        textView.font = UIFont(name: notoSansFont.Regular.rawValue, size: 13)
        textView.clipsToBounds = true
        
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.862745098, blue: 0.8588235294, alpha: 1)
        textView.layer.borderWidth = 1
        return textView
    }()
    
    //바로 가기 버튼
    var goDetailBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 291, y: 257, width: 48, height: 48))
        btn.titleLabel?.font = UIFont(name: notoSansFont.Regular.rawValue, size: 13)
        btn.setTitle("바로가기", for: .normal)
        
        return btn
    }()
    
    //바로 가기 이미지
    var goDetailImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 327, y: 257, width: 48, height: 48))
        imageView.image = #imageLiteral(resourceName: "donation-arrow-right")
        return imageView
    }()
    
    //금액 선택 버튼
    var selectTF: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 20, y: 505, width: 199, height: 34))
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        textfield.attributedPlaceholder = NSAttributedString(string: "금액 선택", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1296959221, green: 0.8359363675, blue: 0.5591831207, alpha: 1), NSAttributedStringKey.paragraphStyle: centeredParagraphStyle ])
        
        textfield.layer.borderColor = #colorLiteral(red: 0.1296959221, green: 0.8359363675, blue: 0.5591831207, alpha: 1)
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 10
        
        return textfield
    }()
    
    
    
    
    //기부하기 버튼
    var donateBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 238, y: 505, width: 117, height: 34))
        btn.titleLabel?.font = UIFont(name: notoSansFont.Regular.rawValue, size: 17)
        btn.setTitle("기부하기", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.1296959221, green: 0.8359363675, blue: 0.5591831207, alpha: 1), for: .normal)
        
        btn.layer.borderColor = #colorLiteral(red: 0.1296959221, green: 0.8359363675, blue: 0.5591831207, alpha: 1)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(_ parentView: UIScrollView){
        super.init(frame: parentView.frame)
        self.parentView = parentView
        
        identifyViews()
        
        parentView.subviews.last?.addSubview(mainImageView)
        parentView.subviews.last?.addSubview(goDetailBtn)
        parentView.subviews.last?.addSubview(goDetailImage)
        
        parentView.subviews.last?.addSubview(typeImageView)
        parentView.subviews.last?.addSubview(titleLabel)
        parentView.subviews.last?.addSubview(explainTextView)
        
        parentView.subviews.last?.addSubview(selectTF)
        parentView.subviews.last?.addSubview(donateBtn)
        
        
    }
    
    
    func identifyViews(){
        
        if parentView?.subviews.last?.accessibilityIdentifier == "asia" {
            mainImageView.image = #imageLiteral(resourceName: "donation-banner-1")
            typeImageView.image = #imageLiteral(resourceName: "donation-tree")
            titleLabel.text = "사막화 방지를 위한 나무 기부"
            explainTextView.text = "   사막화, 황사를 막을 수 있는 유일한 해결책은 나무를\n   심는 일입니다. 한 사람이 평생 열 그루의 나무를 \n   심는다면 기후변화, 사막화, 황사를 방지할 수\n   있습니다.이는 나무 열 그루를 심어 이산화탄소를  \n   흡수하는 효과도 크겠지만 더 중요한 것은 사람들의 \n   마음과 삶의 변화를 뜻하는 것입니다. 사람의 마음이\n   바뀌면 기후변화, 사막화 문제도 해결될 수 있습니다.\n   에코마일리지 회원들의 기부는 나무 한 그루, \n   한 그루가 모여 숲이 이루어지듯 사막화 방지의 \n   큰 밑거름이 될 것입니다."
        }
        if parentView?.subviews.last?.accessibilityIdentifier ==  "forest" {
            mainImageView.image = #imageLiteral(resourceName: "donation-banner-2")
            typeImageView.image = #imageLiteral(resourceName: "donation-tree")
            titleLabel.text = "사막화 방지를 위한 나무 기부"
            explainTextView.text = "   사막화, 황사를 막을 수 있는 유일한 해결책은 나무를\n   심는 일입니다. 한 사람이 평생 열 그루의 나무를 \n   심는다면 기후변화, 사막화, 황사를 방지할 수\n   있습니다.이는 나무 열 그루를 심어 이산화탄소를  \n   흡수하는 효과도 크겠지만 더 중요한 것은 사람들의 \n   마음과 삶의 변화를 뜻하는 것입니다. 사람의 마음이\n   바뀌면 기후변화, 사막화 문제도 해결될 수 있습니다.\n   에코마일리지 회원들의 기부는 나무 한 그루, \n   한 그루가 모여 숲이 이루어지듯 사막화 방지의 \n   큰 밑거름이 될 것입니다."
        }
        if parentView?.subviews.last?.accessibilityIdentifier ==  "energy" {
            mainImageView.image = #imageLiteral(resourceName: "donation-banner-3")
            typeImageView.image = #imageLiteral(resourceName: "donation-energy")
            titleLabel.text = "에너지 빈곤층을 위한 기부"
            explainTextView.text = "   별다른 생각 없이 쓰는 에너지, 그러나 우리 주위에는\n   에너지가 없어 생활의 불편함을 겪고 있는 이웃들이 \n   있습니다.작은 방 하나를 데울 수 없고, 좁은 \n   공간조차 밝힐 수 없는 이웃에게 따뜻한 에너지를 \n   전해주세요. 우리들의 작은 배려로 아낀 에너지가 \n   에너지 빈곤층에게 큰 도움이 됩니다. 시민들의 기부는\n   태양광에너지 설치, 주거에너지효율화, 에너지효율 \n   제품 지원 등에 쓰입니다. 서울에너지복지시민기금은 \n   에너지 나눔을 실천합니다."
            
        }
    }
    
    
}


