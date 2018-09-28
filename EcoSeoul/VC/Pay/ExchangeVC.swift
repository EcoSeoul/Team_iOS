//
//  ExchangeVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController, APIService {
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    let userName = UserDefaults.standard.string(forKey: "userName")!
    let userMileage = UserDefaults.standard.string(forKey: "userMileage")!
    
    @IBOutlet var superView: UIControl!
    @IBOutlet weak var exchangeView: UIControl!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var totalBtn: UIButton!
    @IBOutlet weak var moneyTF: UITextField!
    @IBOutlet weak var changeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyTF.delegate = self;
        
        initData()
        makeBtnBorder()
        makeExchangeView()
     
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    

    @IBAction func totalBtnPressed(_ sender: Any) {
        print("전액버튼을 눌렀습니다.")
        moneyTF.textAlignment = .justified
        moneyTF.text = userMileage
    }
    
    @IBAction func chnageBtnPressed(_ sender: Any) {
        print("에코머니로 전환버튼을 눌렀습니다.")
        removeAnimate()
        //1.빔 애니메이션 넣기
        
        //2.통신구현부
        let params: [String:Any] = [
            "user_idx" : userIdx,
            "exchange" : gino(Int(moneyTF.text!))
        ]
        
        ExchangeService.shareInstance.exchange(url: url("/mypage/exchange"), params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let data):
                print(data)
                //성공시 할 이벤트
                break
            case .insufficient:
                self.simpleAlert(title: "오류", message: "환전할 마일리지가 부족합니다 ㅠ.ㅠ")
                
            case .wrongInput:
                self.simpleAlert(title: "오류", message: "보유 마일리지가 2만이 넘어야 환전 가능!")
         
            case .minimumValue:
                self.simpleAlert(title: "오류", message: "환전 최소 금액은 1만 마일리지 입니다!")
            case .nullValue :
                self.simpleAlert(title: "오류", message: "값을 다시 입력해주세요 :)")
            default :break
            }
        })
    }


    func initData(){
        
        userNameLabel.text = "\(userName)님"
        mileageLabel.text = String(userMileage)
    }
    
    func makeBtnBorder(){
        changeBtn.layer.cornerRadius = 10
        changeBtn.layer.borderWidth = 1
        changeBtn.layer.borderColor = #colorLiteral(red: 0.1296959221, green: 0.8359363675, blue: 0.5591831207, alpha: 1)
        
        totalBtn.layer.cornerRadius = 10
        totalBtn.layer.borderWidth = 1
        totalBtn.layer.borderColor = #colorLiteral(red: 0.1296959221, green: 0.8359363675, blue: 0.5591831207, alpha: 1)
    }
    
    func makeExchangeView(){
        exchangeView.layer.cornerRadius = 20;
        exchangeView.layer.masksToBounds = true;
        self.superView.addTarget(self, action: #selector(subViewTapped), for: .allTouchEvents)
        
    }
    
    @objc func subViewTapped(){
        self.removeAnimate()
        self.view.removeFromSuperview()
    }



}

extension ExchangeVC: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
 
    
}
extension ExchangeVC {
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
}
