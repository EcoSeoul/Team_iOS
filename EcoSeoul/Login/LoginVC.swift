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

 
    @IBAction func loginBtn(_ sender: Any) {
        enterHome()
    }
    @IBAction func signupBtn(_ sender: Any) {
        
    }

    func enterHome() {
        
        guard let homeVC = UIStoryboard(name: "HomeUp", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else { return }
        
        self.present(homeVC, animated: true, completion: nil)
        
    }
}
