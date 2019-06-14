//
//  SignUpViewController.swift
//  BeautyAndBeast
//
//  Created by 如昀李 on 2019/6/12.
//  Copyright © 2019年 李如昀. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var accountTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var SignButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SignButton.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignupButton(_ sender: UIButton)
    {
        Auth.auth().createUser(withEmail: accountTxt.text!, password: passwordTxt.text!){(user, error) in
            if user != nil
            {
                print("User Created")
                self.performSegue(withIdentifier: "tologin", sender: self)
                
            }else
            {
                print("error")
            }
            
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
