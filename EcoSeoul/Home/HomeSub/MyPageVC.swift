//
//  MyPageVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self;
        tableview.dataSource = self;
 
    }

    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
}

extension MyPageVC:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            switch row {
                case 0:
                    //신청내역으로 present
                    break
                case 1:
                    //기부내역으로 present
                    break
                case 2:
                    //내가 쓴 글로 present
                    break
                case 3:
                    let cardVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "CardVC") as! CardVC
                    self.present(cardVC, animated: true, completion: nil)
                default: break
            }
        }
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "MyPageTVC") as! MyPageTVC
        switch indexPath.row {
            case 0:
                cell.titleLB.text = "신청 내역"
            case 1:
                cell.titleLB.text = "기부 내역"
            case 2:
                cell.titleLB.text = "내가 쓴 글"
            case 3:
                cell.titleLB.text = "카드 등록하기"
            default:
                break
            }
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
    
}
