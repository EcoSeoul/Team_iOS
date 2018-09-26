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

class AffiliationVC: UIViewController, APIService {

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
            
        case 1: //강북,도봉
            seoulMap.image = #imageLiteral(resourceName: "a-gangbook")
        case 3: //성북
            seoulMap.image = #imageLiteral(resourceName: "a-seongbook")
        case 4: //노원
            seoulMap.image = #imageLiteral(resourceName: "a-nowon")
        case 5: //동대문
            seoulMap.image = #imageLiteral(resourceName: "a-dongdaemoon")
        case 6: //중랑
            seoulMap.image = #imageLiteral(resourceName: "a-joongrang")
        case 7: //성동
            seoulMap.image = #imageLiteral(resourceName: "a-seongdong")
        case 8: //광진
            seoulMap.image = #imageLiteral(resourceName: "a-gwangjin")
        case 9: //강동
            seoulMap.image = #imageLiteral(resourceName: "a-gangdong")
        case 10: //송파
            seoulMap.image = #imageLiteral(resourceName: "a-songpa")
        case 11: //서초
            seoulMap.image = #imageLiteral(resourceName: "a-seocho")
        case 12: //강남
            seoulMap.image = #imageLiteral(resourceName: "a-gangnam")
        case 13: //종로,서대문
            seoulMap.image = #imageLiteral(resourceName: "a-jongro")
        case 14: //중구,용산
            seoulMap.image = #imageLiteral(resourceName: "a-yongsan")
        case 16: //동작
            seoulMap.image = #imageLiteral(resourceName: "a-dongjak")
        case 17: //금천,관악
            seoulMap.image = #imageLiteral(resourceName: "a-geumcheon")
        case 18: //강서
            seoulMap.image = #imageLiteral(resourceName: "a-gangseo")
        case 19: //양천,구로
            seoulMap.image = #imageLiteral(resourceName: "a-yangcheon")
        case 20: //영등포
            seoulMap.image = #imageLiteral(resourceName: "a-yeongdeungpo")
        case 21: //은평
            seoulMap.image = #imageLiteral(resourceName: "a-eunpyeong")
        case 22: //마포
            seoulMap.image = #imageLiteral(resourceName: "a-mapo")
        default: break
        }
        
        //통신
        franDataInit(url : url("/franchise/\(tag)"))
      
        let affiliationDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "AffiliationDetailVC") as! AffiliationDetailVC
        affiliationDetailVC.guIdx = tag
        self.navigationController?.pushViewController(affiliationDetailVC, animated: true)
        
    }
    
    
    
    func franDataInit(url : String){
        FranchiseService.shareInstance.getFranchiseData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let data):
                print(data)
                break
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
                break
            default :
                break
            }
        })
        
    }
        
}
    

