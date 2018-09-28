//
//  ExchangeVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController {
    
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
        moneyTF.text = userMileage
        
    }
    
    @IBAction func chnageBtnPressed(_ sender: Any) {
        print("에코머니로 전환버튼을 눌렀습니다.")
        removeAnimate()
        //빔 애니메이션 넣기
        //통신구현부
        

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
