//
//  MyPageVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController, APIService {
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var mileageLB: UILabel!
    @IBOutlet weak var moneyLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self;
        tableview.dataSource = self;
        network()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        network()
    }
    
    func network(){
         myPageInit(url: url("/mypage/\(userIdx)"))
    }

    func myPageInit(url: String){
        MyPageService.shareInstance.getMyPageData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
                case .networkSuccess(let data):
                    UserDefaults.standard.set(data.userMoney, forKey: "userMoney")
                    self.mileageLB.text = String(data.userMileage)
                    self.moneyLB.text = String(data.userMoney)
                break
            case .networkFail :
                self.simpleAlert(title: "network", message: "네트워크 환경을 확인해주세요 :)")
                break
            default :
                break
            }
        })
        
    }

    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func mileageDetailBtn(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "check")
        let mileageVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "PayVC") as! PayVC
        
        self.present(mileageVC, animated: true, completion: nil)
    }
    
    @IBAction func moneyDetailBtn(_ sender: Any) {
        
        UserDefaults.standard.set(1, forKey: "check")
        let moneyVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "PayVC") as! PayVC
     
        self.present(moneyVC, animated: true, completion: nil)
    }
    
    @IBAction func exchangeBtn(_ sender: Any) {
        let exchangeVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "ExchangeVC")as! ExchangeVC
        self.addChildViewController(exchangeVC)
        
       exchangeVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

        self.view.addSubview(exchangeVC.view)
        exchangeVC.didMove(toParentViewController: self)
    }
    
    @IBAction func faqBtn(_ sender: Any) {
        let faqVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "FAQVC") as! FAQVC
        self.present(faqVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        
        //performSegue(withIdentifier: "GoToMain", sender: self)
        //Alert를 만들고
        //거기서 확인버튼을 누르면 PerformASergu가 수행되게 유도
        
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃을 하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) {
            _ in
            self.performSegue(withIdentifier: "GoToMain", sender: self)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

extension MyPageVC:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row
        
        //셀 클릭이후 남아있는 gray color 없애기
        tableView.deselectRow(at: indexPath, animated: true)
        
        if section == 0 {
            switch row {
                case 0:
                    UserDefaults.standard.set(0, forKey: "check")
                    let listVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListVC
                    self.present(listVC, animated: true, completion: nil)
                    
                    break
                case 1:
                    UserDefaults.standard.set(1, forKey: "check")
                    let listVC = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListVC
                    self.present(listVC, animated: true, completion: nil)
                    break
                case 2:
                    UserDefaults.standard.set(2, forKey: "check")
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
        cell.selectionStyle = .none
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
