//
//  CardVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CardVC: UIViewController {

    @IBOutlet weak var pickerTextField: UITextField!
    
    let cardArray = ["우리은행", "SC제일", "NH농협", "IBK기업"]
    let pickerview = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()


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
        pickerTextField.inputAccessoryView = bar
        pickerTextField.inputView = pickerview
    }
    
    @objc func selectedPicker(){
        let row = pickerview.selectedRow(inComponent: 0)
        
        // 선택된 항목 textField에 넣기.
        pickerTextField.text = cardArray[row]
        
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
