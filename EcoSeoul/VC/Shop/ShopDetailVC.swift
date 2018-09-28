//
//  ShopDetailVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 23..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class ShopDetailVC: UIViewController, APIService {

    var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "arrow-left-black")
        btn.tintColor = UIColor.black
        btn.width = -40
        btn.action = #selector(popSelf)
        return btn
    }()
    
    var myPageBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "ic-mypage")
        btn.tintColor = .black
        btn.action = #selector(goMyPageVC)
        return btn
    }()
    
    @objc func popSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func goMyPageVC(){
        let myPageVC = UIStoryboard(name: "HomeSub", bundle: nil).instantiateViewController(withIdentifier: "MyPageVC") as! MyPageVC
        self.present(myPageVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var companyLB: UILabel!
    @IBOutlet weak var imageIMG: UIImageView!
    @IBOutlet weak var summeryLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    
    var selectedShop : ShopData?
    var detailVew : ShopView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        if let shopIdx = selectedShop?.goodsIdx{
            print("내가 들어간 shopIDX")
            print(shopIdx)
            ShopDetailInit(url: url("/shop/\(shopIdx)"))
        }
    }
    
    func ShopDetailInit(url : String){
        
        ShopDetailService.shareInstance.getShopDetailData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
                
            case .networkSuccess(let view):
                self.detailVew = view
                print("\n detailView에 잘 들어가는지 확인하기\n")
                print(self.detailVew!)
                self.showShopData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }
    
    func showShopData(){
        if let shopresult = self.detailVew?.shopDetail {
            self.nameLB.text = shopresult[0].goodsName
            self.companyLB.text = shopresult[0].goodsCompany
            self.contentLB.text = shopresult[0].goodsContent
            self.summeryLB.text = shopresult[0].goodsSummery
//            self.imageIMG.image = shopresult[0].goodsImg
        }
    }

    
    func setNaviBar(){
        backBtn.target = self
        myPageBtn.target = self
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        let item: UINavigationItem = self.navigationItem
        
        
        item.leftBarButtonItem = backBtn
        item.leftBarButtonItem?.imageInsets.left = -15
        item.rightBarButtonItem = myPageBtn
        item.rightBarButtonItem?.imageInsets.right = -15
        
        bar.backgroundColor = .white
        item.title = "상품 신청하기"
        bar.shadowImage = UIImage()
        
    }
    
    //상태 표시줄 흰색 만들기
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

