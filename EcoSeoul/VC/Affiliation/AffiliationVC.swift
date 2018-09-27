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

    var frcIdxArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        seoulMap.image = #imageLiteral(resourceName: "affiliate-map")
    }
  
    @IBAction func pressedBtn(_ sender: UIButton) {
        
        let tag = sender.tag
        
        switch tag {
            
        case 1: seoulMap.image = #imageLiteral(resourceName: "a-gangbook"); break; //강북,도봉
        case 3: seoulMap.image = #imageLiteral(resourceName: "a-seongbook"); break; //성북
        case 4: seoulMap.image = #imageLiteral(resourceName: "a-nowon"); break; //노원
        case 5: seoulMap.image = #imageLiteral(resourceName: "a-dongdaemoon"); break; //동대문
        case 6: seoulMap.image = #imageLiteral(resourceName: "a-joongrang"); break; //중랑
        case 7: seoulMap.image = #imageLiteral(resourceName: "a-seongdong"); break; //성동
        case 8: seoulMap.image = #imageLiteral(resourceName: "a-gwangjin"); break; //광진
        case 9: seoulMap.image = #imageLiteral(resourceName: "a-gangdong"); break; //강동
        case 10: seoulMap.image = #imageLiteral(resourceName: "a-songpa");break; //송파
        case 11: seoulMap.image = #imageLiteral(resourceName: "a-seocho");break; //서초
        case 12: seoulMap.image = #imageLiteral(resourceName: "a-gangnam");break; //강남
        case 13: seoulMap.image = #imageLiteral(resourceName: "a-jongro");break; //종로,서대문
        case 14: seoulMap.image = #imageLiteral(resourceName: "a-yongsan");break; //중구,용산
        case 16: seoulMap.image = #imageLiteral(resourceName: "a-dongjak");break; //동작
        case 17: seoulMap.image = #imageLiteral(resourceName: "a-geumcheon");break; //금천,관악
        case 18: seoulMap.image = #imageLiteral(resourceName: "a-gangseo");break; //강서
        case 19: seoulMap.image = #imageLiteral(resourceName: "a-yangcheon");break; //양천,구로
        case 20: seoulMap.image = #imageLiteral(resourceName: "a-yeongdeungpo");break; //영등포
        case 21: seoulMap.image = #imageLiteral(resourceName: "a-eunpyeong");break; //은평
        case 22: seoulMap.image = #imageLiteral(resourceName: "a-mapo");break; //마포
        default: break
        }
        
        franDataInit(url : url("/franchise/\(tag)"))
        
        
    }
    
    func franDataInit(url : String){
        FranchiseService.shareInstance.getFranchiseData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let data):
                self.setDB(data)
                let affiliationDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "AffiliationDetailVC") as! AffiliationDetailVC
                affiliationDetailVC.frcIdxArr = self.frcIdxArray
                self.navigationController?.pushViewController(affiliationDetailVC, animated: true)
                break
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
                break
            default :
                break
            }
        })
        
    }
    
    
    
    func setDB(_ data: [FranchiseData]){
        let dataNum = data.count
        for i in 0..<dataNum {
            self.frcIdxArray.append(data[i].frcIdx)
        }
    }
    
    
        
}

extension AffiliationVC {
    
    @objc func popSelf() {
        navigationController?.popViewController(animated: true)
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
    
    
}
    

