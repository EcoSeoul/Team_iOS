//
//  CardVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CardVC: UIViewController {

    @IBOutlet weak var pickerTF: UITextField!
    @IBOutlet weak var cardNumberTF: UITextField!
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    let cardArray = ["우리은행", "SC제일", "NH농협", "IBK기업"]
    let pickerview = UIPickerView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerTF.delegate = self;
        cardNumberTF.delegate = self;
        initPicker()
    }

    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func makeCardBtn(_ sender: Any) {
        UserDefaults.standard.set(cardNumberTF.text!, forKey: "userBarCode")
        self.dismiss(animated: true, completion: nil)
        //카드 등록이 완료되었습니다 창 띄우기..(1~2초)
    }
    
    @IBAction func makeCardSiteBtn(_ sender: Any) {
        
        //카드 신청하러 가기 버튼(웹으로 연결)
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
        self.pickerview.dataSource = self
        
        let bar = UIToolbar()
        bar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker))
        
        bar.setItems([doneButton], animated: true)
        pickerTF.inputAccessoryView = bar
        pickerTF.inputView = pickerview
    }
    
    @objc func selectedPicker(){
        let row = pickerview.selectedRow(inComponent: 0)
        
        // 선택된 항목 textField에 넣기.
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
