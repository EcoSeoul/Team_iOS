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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        seoulMap.image = #imageLiteral(resourceName: "affiliate-map")
    }
  
    @IBAction func pressedBtn(_ sender: UIButton) {
        
        let tag = sender.tag
        
        switch tag {
            
        case 0:
            seoulMap.image = #imageLiteral(resourceName: "a-gangseo")
        case 1:
            seoulMap.image = #imageLiteral(resourceName: "a-yangcheon")
        case 2:
            seoulMap.image = #imageLiteral(resourceName: "a-geumcheon")
        case 3:
            seoulMap.image = #imageLiteral(resourceName: "a-seocho")
        case 4:
            seoulMap.image = #imageLiteral(resourceName: "a-gangnam")
        case 5:
            seoulMap.image = #imageLiteral(resourceName: "a-songpa")
        case 6:
            seoulMap.image = #imageLiteral(resourceName: "a-gangdong")
        case 7:
            seoulMap.image = #imageLiteral(resourceName: "a-gwangjin")
        case 8:
            seoulMap.image = #imageLiteral(resourceName: "a-joongrang")
        case 9:
            seoulMap.image = #imageLiteral(resourceName: "a-nowon")
        case 10:
            seoulMap.image = #imageLiteral(resourceName: "a-gangbook")
        case 11:
            seoulMap.image = #imageLiteral(resourceName: "a-eunpyeong")
        case 12:
            seoulMap.image = #imageLiteral(resourceName: "a-mapo")
        case 13:
            seoulMap.image = #imageLiteral(resourceName: "a-yeongdeungpo")
        case 14:
            seoulMap.image = #imageLiteral(resourceName: "a-dongjak")
        case 15:
            seoulMap.image = #imageLiteral(resourceName: "a-yongsan")
        case 16:
            seoulMap.image = #imageLiteral(resourceName: "a-seongdong")
        case 17:
            seoulMap.image = #imageLiteral(resourceName: "a-dongdaemoon")
        case 18:
            seoulMap.image = #imageLiteral(resourceName: "a-seongbook")
        case 19:
            seoulMap.image = #imageLiteral(resourceName: "a-jongro")
        default: print("!")
        }
        
        let affiliationDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "AffiliationDetailVC") as! AffiliationDetailVC
        
        self.navigationController?.pushViewController(affiliationDetailVC, animated: true)
        }
        
}
    

