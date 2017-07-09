//
//  phoneVC.swift
//  phone
//
//  Created by Sawkan Team on 03/07/17.
//  Copyright © 2017 Sawkan Team. All rights reserved.
//

import UIKit
import Firebase
class phoneVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var txtfield: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var send: UIButton!

    @IBAction func sendbtn(_ sender: Any) {
        
        
        PhoneAuthProvider.provider().verifyPhoneNumber(txtfield.text!) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print(verificationID!)
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            // Sign in using the verificationID and the code sent to the user
            // ...
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
