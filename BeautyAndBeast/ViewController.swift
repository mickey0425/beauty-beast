//
//  ViewController.swift
//  BeautyAndBeast
//
//  Created by 李如昀 on 2019/5/29.
//  Copyright © 2019 李如昀. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import FirebaseMLCommon

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    var email: String!
    var password: String!
    
    @IBOutlet weak var goSinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        goSinButton.layer.cornerRadius = 20
      
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        
//        self.navigationItem.hidesBackButton = true
        
        emailTxt.text! = "123@abc.com"
        passwordTxt.text! = "123456789"
    }
    
    @IBAction func LoginBtn(_ sender: UIButton) {
        
       
        
        Auth.auth().signIn(withEmail: emailTxt.text!, password: passwordTxt.text!) {(user, error) in
            
            if user != nil
            {
                self.performSegue(withIdentifier: "login", sender: self)
                print("loginSuccess")
            }
            else
            {
                let alert = UIAlertController(title: "發生問題", message: nil, preferredStyle:.alert)
                let OKbtn = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKbtn)
                self.present(alert, animated: true, completion: nil )
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

