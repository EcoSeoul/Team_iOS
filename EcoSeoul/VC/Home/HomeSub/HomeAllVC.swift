//
//  HomeAllVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 14..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class HomeAllVC: UIViewController {

    @IBOutlet weak var Tableview: UITableView!
    @IBOutlet weak var periodLB: UILabel!
    @IBOutlet weak var carbonLB: UILabel!
    @IBOutlet weak var upDownImg: UIImageView!
    @IBOutlet weak var percentLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Tableview.delegate = self
        self.Tableview.dataSource = self

    }

    @IBAction func dismissPressed(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
}

extension HomeAllVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeAllTVC") as! HomeAllTVC
        
        cell.monthLB.text = "8"
        
        if indexPath.row == 0{
            cell.itemLB.text = "전기"
            cell.itemIMG.image = #imageLiteral(resourceName: "home-all-electric")
            ///받은 데이터 입력
            cell.useageLB.text = "1000"
            cell.percentLB.text = "10"
            cell.explainLB.text = "작년보다 70%를 절약한 당신! 최고에요!"
        }else if indexPath.row == 1{
            
            cell.itemLB.text = "수도"
            cell.itemIMG.image = #imageLiteral(resourceName: "home-all-water")
            ///받은 데이터 입력
            cell.useageLB.text = "1000"
            cell.percentLB.text = "10"
            cell.explainLB.text = "작년보다 70%를 절약한 당신! 최고에요!"
        }else {
            cell.itemLB.text = "도시가스"
            cell.itemIMG.image = #imageLiteral(resourceName: "home-all-gas")
            ///받은 데이터 입력
            cell.useageLB.text = "1000"
            cell.percentLB.text = "10"
            cell.explainLB.text = "작년보다 70%를 절약한 당신! 최고에요!"
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
