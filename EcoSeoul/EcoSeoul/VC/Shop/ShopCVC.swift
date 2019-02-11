//
//  ShopCVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 23..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ShopCVCell"

class ShopCVC: UICollectionViewController, APIService{
    
    var shopData_ : Shop?

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        getShopInit(url: url("/shop"))
    }
    
    func getShopInit(url : String){
        
        ShopService.shareInstance.shopInit(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
                
            case .networkSuccess(let data):
                self.shopData_ = data
                self.collectionView?.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
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
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rownumber : Int = 0
        if let Num = shopData_?.shopData {
            rownumber = Num.count
        }
        return rownumber
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCVCell", for: indexPath) as! ShopCVCell
        
        if let data = shopData_?.shopData{
            if let cellContent: ShopData = data[indexPath.row]{
                cell.configure(shops: cellContent)
            }
        }
        switch indexPath.row {
        case 0:
            cell.shopIMG.image = #imageLiteral(resourceName: "shop-tent")
        case 1:
            cell.shopIMG.image = #imageLiteral(resourceName: "shop-tumbler")
        case 2:
            cell.shopIMG.image = #imageLiteral(resourceName: "shop-stand")
        case 3:
            cell.shopIMG.image = #imageLiteral(resourceName: "shop-market-voucher")
        case 4:
            cell.shopIMG.image = #imageLiteral(resourceName: "shop-culture-voucher")
        case 5:
            cell.shopIMG.image = #imageLiteral(resourceName: "shop-socket")
        case 6:
            cell.shopIMG.image = #imageLiteral(resourceName: "shop-apti")
        case 7:
            cell.shopIMG.image = #imageLiteral(resourceName: "shop-tmoney")
        case 8:
            cell.shopIMG.image = #imageLiteral(resourceName: "shop-cash")
        default:
            break
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shopDetailVC = UIStoryboard(name: "Shop", bundle: nil).instantiateViewController(withIdentifier: "ShopDetailVC")as! ShopDetailVC
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCVCell", for: indexPath) as! ShopCVCell
        
        if let data = shopData_?.shopData[indexPath.row] {
            shopDetailVC.selectedShop = data
            //            if cell.shopIMG != nil{
            //                shopDetailVC.itemImg = cell.shopIMG.image
            //            }else{
            //                cell.shopIMG.image = #imageLiteral(resourceName: "shop-tmoney")
            //            }
        }
        self.navigationController?.pushViewController(shopDetailVC, animated: true)
    }
    
}
