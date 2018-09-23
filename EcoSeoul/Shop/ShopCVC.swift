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

    override func viewDidLoad() {
        super.viewDidLoad()
        

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
