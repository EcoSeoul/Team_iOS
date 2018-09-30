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
    var itemImg : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        if let shopIdx = selectedShop?.goodsIdx{
            print("내가 들어간 shopIDX")
            print(shopIdx)
            ShopDetailInit(url: url("/shop/\(shopIdx)"))
        }
    }
    @IBAction func applyItemBtn(_ sender: Any) {
        if let shopresult = self.detailVew?.shopDetail{
            let params : [String : Any] = [
                "goods_idx" : shopresult[0].goodsIdx,
                "goods_name" : shopresult[0].goodsName,
                "goods_price" : shopresult[0].goodsPrice,
                "user_idx" : UserDefaults.standard.string(forKey: "userIdx")!
            ]
            print("paramssssssss")
            print(params)
            
            self.simpleAlertwithHandler(title: "신청하기", message: "이 상품으로 신청하시겠습니까?", okHandler: { (_) in  ShopApplyService.shareInstance.applyitem(url: self.url("/shop"), params: params) { [weak self] (result) in
                guard let `self` = self else { return }
                switch result {
                case .networkSuccess(_):
                    print("왜 여기는 동작을 안할까?")
                    
                    self.registerCompleteView()
                case .nullValue :
                    self.simpleAlert(title: "오류", message: "텍스트 비어있음")
                case .networkFail :
                    self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
                default :
                    break
                }
                print("신청완료 ")
                }
            })
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
            switch selectedShop?.goodsIdx {
            case 8:
                self.imageIMG.image = #imageLiteral(resourceName: "shop-tent")
            case 9:
                self.imageIMG.image = #imageLiteral(resourceName: "shop-tumbler")
            case 10:
                self.imageIMG.image = #imageLiteral(resourceName: "shop-stand")
            case 14:
                self.imageIMG.image = #imageLiteral(resourceName: "shop-market-voucher")
            case 15:
                self.imageIMG.image = #imageLiteral(resourceName: "shop-culture-voucher")
            case 17:
                self.imageIMG.image = #imageLiteral(resourceName: "shop-socket")
            case 18:
                self.imageIMG.image = #imageLiteral(resourceName: "shop-apti")
            case 20:
                self.imageIMG.image = #imageLiteral(resourceName: "shop-tmoney")
            case 21:
                self.imageIMG.image = #imageLiteral(resourceName: "shop-cash")
            default:
                break
            }
        }
    }

    func registerCompleteView() {
        let registerShopVC = UIStoryboard(name: "Shop", bundle: nil).instantiateViewController(withIdentifier: "registerShopVC")as! registerShopVC
        self.addChildViewController(registerShopVC)
        
        registerShopVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(registerShopVC.view)
        registerShopVC.didMove(toParentViewController: self)
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


