//
//  verifyVC.swift
//  phone
//
//  Created by Sawkan Team on 03/07/17.
//  Copyright © 2017 Sawkan Team. All rights reserved.
//

import UIKit
import Firebase

class verifyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var txtfield: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func verifybtn(_ sender: Any) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!,verificationCode: txtfield.text!)
        
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                 print(error.localizedDescription)
                return
            }
            
            
             print(user?.phoneNumber)
            let userinfo = user?.providerData[0]
            print(userinfo?.providerID)
            
           
            // ...
        }
    
        
        
        
        
   
    }

    @IBOutlet weak var verify: UIButton!
   }
