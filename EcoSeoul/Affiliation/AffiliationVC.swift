//
//  AffiliationVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
//제휴업체 표시
//서울시 전역 지도

class AffiliationVC: UIViewController {

    @IBOutlet weak var seoulMap: UIImageView!
    
    var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "arrow-left-black")
        btn.tintColor = UIColor.black
        btn.width = -40
        btn.action = #selector(popSelf)
        return btn
    }()

    @objc func popSelf() {
        navigationController?.popViewController(animated: true)
    }
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()

    }
    
    func setNaviBar(){
        backBtn.target = self
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        let item: UINavigationItem = self.navigationItem
        
        item.leftBarButtonItem = backBtn
        item.leftBarButtonItem?.imageInsets.left = -15
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        seoulMap.image = #imageLiteral(resourceName: "affiliate-map")
    }
  
    @IBAction func pressedBtn(_ sender: UIButton) {
        
        let tag = sender.tag
        
        switch tag {
            
        case 0: //강서
            seoulMap.image = #imageLiteral(resourceName: "a-gangseo")
        case 1: //양천,구로
            seoulMap.image = #imageLiteral(resourceName: "a-yangcheon")
        case 2: //금천,관악
            seoulMap.image = #imageLiteral(resourceName: "a-geumcheon")
        case 3: //서초
            seoulMap.image = #imageLiteral(resourceName: "a-seocho")
        case 4: //강남
            seoulMap.image = #imageLiteral(resourceName: "a-gangnam")
        case 5: //송파
            seoulMap.image = #imageLiteral(resourceName: "a-songpa")
        case 6: //강동
            seoulMap.image = #imageLiteral(resourceName: "a-gangdong")
        case 7: //광진
            seoulMap.image = #imageLiteral(resourceName: "a-gwangjin")
        case 8: //중랑
            seoulMap.image = #imageLiteral(resourceName: "a-joongrang")
        case 9: //노원
            seoulMap.image = #imageLiteral(resourceName: "a-nowon")
        case 10: //강북,도봉
            seoulMap.image = #imageLiteral(resourceName: "a-gangbook")
        case 11: //은평
            seoulMap.image = #imageLiteral(resourceName: "a-eunpyeong")
        case 12: //마포
            seoulMap.image = #imageLiteral(resourceName: "a-mapo")
        case 13: //영등포
            seoulMap.image = #imageLiteral(resourceName: "a-yeongdeungpo")
        case 14: //동작
            seoulMap.image = #imageLiteral(resourceName: "a-dongjak")
        case 15: //중구,용산
            seoulMap.image = #imageLiteral(resourceName: "a-yongsan")
        case 16: //성동
            seoulMap.image = #imageLiteral(resourceName: "a-seongdong")
        case 17: //동대문
            seoulMap.image = #imageLiteral(resourceName: "a-dongdaemoon")
        case 18: //성북
            seoulMap.image = #imageLiteral(resourceName: "a-seongbook")
        case 19: //종로,서대문
            seoulMap.image = #imageLiteral(resourceName: "a-jongro")
        default: print("!")
        }
        
        let affiliationDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "AffiliationDetailVC") as! AffiliationDetailVC
        affiliationDetailVC.districtTag = tag
        self.navigationController?.pushViewController(affiliationDetailVC, animated: true)
        }
        
}
    

