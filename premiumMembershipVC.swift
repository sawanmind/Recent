//
//  premiumMembershipVC.swift
//  Live Vaastu
//
//  Created by Sawkan Team on 29/06/17.
//  Copyright © 2017 Sawkan Team. All rights reserved.
//

import UIKit
import StoreKit
class premiumMembershipVC: UIViewController , SKPaymentTransactionObserver, SKProductsRequestDelegate{


   
    
    var product : SKProduct?
    var ProductID = "com.sawkanInternet.LiveVaastu.UnlockPremium"
    var ProductIDChat10 = "com.sawkanInternet.LiveVaastu.UnlockLivechat10min"
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let save = UserDefaults.standard
        if save.value(forKey: "Purchase") == nil {
           
            SKPaymentQueue.default().add(self)
            getPurchaseInfo()
            
            
        } else {
            
            purchase.isHidden = true
           
        }
        
       
        navigationItem.title = "Membership"
        view.backgroundColor = UIColor.bgColor
       
        
        setuptitletxt()
        setupdesctxt()
        
        setuppurchase()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SKPaymentQueue.default().remove(self)
    }
    
    
    let  titletxt:UILabel = {
        let titletxt = UILabel()
        titletxt.text = "Membership Offer"
        titletxt.backgroundColor = UIColor.clear
        titletxt.font = .boldSystemFont(ofSize: 26)
        titletxt.textColor = UIColor.black
        titletxt.translatesAutoresizingMaskIntoConstraints = false
        return titletxt
    }()
    func setuptitletxt(){
        view.addSubview(titletxt)
        titletxt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titletxt.topAnchor.constraint(equalTo: view.topAnchor,constant: 40).isActive = true
        titletxt.widthAnchor.constraint(equalTo: titletxt.widthAnchor).isActive = true
        titletxt.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }

    
    let  desctxt:UILabel = {
        let desctxt = UILabel()
        desctxt.text = "1.  Lifetime access to Dr. Chawla's Premium Articles.\n\n2. Lifetime access to Dr. Chawla Premium Question & Answer.\n\n3. You will become Premium Member and get 5% additional discount on buying any Live Vaastu products."
        desctxt.font = .systemFont(ofSize: 16)
        desctxt.textColor = UIColor.gray
        desctxt.numberOfLines = 0
        desctxt.lineBreakMode = .byWordWrapping
        desctxt.translatesAutoresizingMaskIntoConstraints = false
        return desctxt
    }()
    func setupdesctxt(){
        view.addSubview(desctxt)
        desctxt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        desctxt.topAnchor.constraint(equalTo: titletxt.bottomAnchor,constant: 30).isActive = true
        desctxt.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        desctxt.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    
    
    
    
    lazy var  purchase:UIButton = {
        let purchase = UIButton(type: .system)
        purchase.setTitle("Purchase Membership", for: .normal)
        purchase.backgroundColor = UIColor.black
        purchase.setTitleColor(UIColor.white, for: .normal)
        purchase.layer.cornerRadius = 23
        purchase.layer.masksToBounds = true
        purchase.isHidden = true
        purchase.setTitleColor(UIColor.red, for: .highlighted)
        purchase.addTarget(self, action: #selector(purchasebtn), for: .touchUpInside)
        purchase.translatesAutoresizingMaskIntoConstraints = false
        return purchase
    }()
    func setuppurchase(){
        view.addSubview(purchase)
        purchase.leftAnchor.constraint(equalTo: view.leftAnchor, constant:10).isActive = true
        purchase.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10).isActive = true
        purchase.widthAnchor.constraint(equalTo: view.widthAnchor ,constant: -20).isActive = true
        purchase.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }



 
  
   
}
