//
//  ShopCVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 23..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ShopCVCell"

class ShopCVC: UICollectionViewController {

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
        // #warning Incomplete implementation, return the number of items
        return 9
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCVCell", for: indexPath) as! ShopCVCell
        
        cell.shopLB.text = "티머니 충전권"
        cell.shopIMG.image = #imageLiteral(resourceName: "shop-tmoney")
        return cell
    }

    
}
