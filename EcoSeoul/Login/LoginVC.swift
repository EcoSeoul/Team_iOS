//
//  LoginVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 14..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    let userId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    ///상단 Navigation Bar 숨기기///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    ///////////////////////////
 
    @IBAction func loginBtn(_ sender: Any) {
        enterHome()
    }
    @IBAction func signupBtn(_ sender: Any) {
        
    }

    func enterHome() {
        
        guard let homeVC = UIStoryboard(name: "HomeUp", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else { return }
        
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
}
