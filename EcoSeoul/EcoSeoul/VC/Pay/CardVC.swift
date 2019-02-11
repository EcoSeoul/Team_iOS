//
//  CardVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CardVC: UIViewController, APIService {
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")

    @IBOutlet weak var pickerTF: UITextField!
    @IBOutlet weak var cardNumberTF: UITextField!
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    let cardArray = ["우리은행", "SC제일", "NH농협", "IBK기업"]
    let pickerview = UIPickerView()
    let completeView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerTF.delegate = self;
        cardNumberTF.delegate = self;
        initPicker()
//        self.completeView.isHidden = true
    }

    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func makeCardBtn(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        //1. 카드 등록이 완료되었습니다 창 띄우기..(1~2초)
//        self.completeView.isHidden = false
//        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
//            self.completeView.isHidden = true
//        }
        //2.통신구현부
        network()
        
    }
    
    func network(){
        
        let params: [String:Any] = [
            "user_idx" : userIdx,
            "user_barcodenum" : gsno(cardNumberTF.text)
        ]
        
        CardService.shareInstance.card(url: url("/mypage/ecocard"), params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let data):
                self.registerCompleteView()
                UserDefaults.standard.set(params["user_barcodenum"], forKey: "userBarcode")
                print(data)
                break
            default :break
            }
        })
        
    }
    func registerCompleteView() {
        let registerCardVC = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "registerCardVC")as! registerCardVC
        self.addChildViewController(registerCardVC)
        
        registerCardVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(registerCardVC.view)
        registerCardVC.didMove(toParentViewController: self)
    }
    
     //카드 신청하러 가기 버튼(웹으로 연결)
    @IBAction func makeCardSiteBtn(_ sender: Any) {
        let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
        webVC.address = "http://ecomileage.seoul.go.kr/home/infomation/introduceEcoCard.do?menuNo=4"
        self.present(webVC, animated: true, completion: nil)
    }
    
    
}

extension CardVC: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

}


extension CardVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func initPicker() {
        
        self.pickerview.delegate = self;
        self.pickerview.dataSource = self;
        
        let bar = UIToolbar()
        bar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker))
        
        bar.setItems([doneButton], animated: true)
        pickerTF.inputAccessoryView = bar
        pickerTF.inputView = pickerview
    }
    
    @objc func selectedPicker(){
        let row = pickerview.selectedRow(inComponent: 0)
        pickerTF.text = cardArray[row]
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cardArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cardArray[row]
    }
    
    
}
