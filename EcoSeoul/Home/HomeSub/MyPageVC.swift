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
    
    @IBAction func mileageDetailBtn(_ sender: Any) { let mileageVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "PayVC") as! PayVC
        self.present(mileageVC, animated: true, completion: nil)
    }
    
    @IBAction func moneyDetailBtn(_ sender: Any) { let moneyVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "PayVC") as! PayVC
        self.present(moneyVC, animated: true, completion: nil)
    }
    
    @IBAction func exchangeBtn(_ sender: Any) {
        
        let exchangeVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "ExchangeVC")as! ExchangeVC
        
        self.addChildViewController(exchangeVC)
        
       exchangeVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    
        
        self.view.addSubview(exchangeVC.view)
        exchangeVC.didMove(toParentViewController: self)
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
                    let listVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListVC
                    self.present(listVC, animated: true, completion: nil)
                    
                    break
                case 1:
                    let listVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListVC
                    self.present(listVC, animated: true, completion: nil)
                    break
                case 2:
                    let listVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListVC
                    self.present(listVC, animated: true, completion: nil)
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
