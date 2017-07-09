//
//  IAPManager.swift
//  Live Vaastu
//
//  Created by Sawkan Team on 28/06/17.
//  Copyright © 2017 Sawkan Team. All rights reserved.
//


import StoreKit
import Firebase

extension premiumMembershipVC {
    
    
    func purchasebtn() {
        
        guard let product = product else {return}
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
        
        
        
    }

    
    


    
    func getPurchaseInfo(){
        
        if SKPaymentQueue.canMakePayments() {
            
            let request = SKProductsRequest(productIdentifiers: NSSet(objects: self.ProductID) as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            self.showAlertViewWithSingleButton(title: "Warning", message: "Please enable in app purchase in the setting ")
            
        }
        
    }

    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        var products = response.products
        
        if products.count == 0 {
            
            self.showAlertViewWithSingleButton(title: "Warning", message: "Product Not Found.")
            
            
        } else {
            
            product  = products[0]
            
            purchase.isHidden = false
        }
        
        let invalids = response.invalidProductIdentifiers
        
        for product in invalids {
            
           self.showAlertViewWithSingleButton(title: "Warning", message: "\(product)")
            
            
        }
        
        
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch  transaction.transactionState {
            case SKPaymentTransactionState.purchased:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                self.showAlertViewWithSingleButton(title: "Thank You", message: "The Product has been purchased.")
              
                purchase.isHidden = true
                
                
                let save = UserDefaults.standard
                save.set(true, forKey: "Purchase")
                save.synchronize()
                
                
      
                
                
                
            case SKPaymentTransactionState.failed:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                self.showAlertViewWithSingleButton(title: "Warning", message:"The Product not has been purchased.")
               
                
                
            default:
                break
            }
        }
        
    }

    
}



extension buyLiveChatVC {
    
    func purchasebtn() {
        
        guard let product = product else {return}
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
        
        
        
    }
    
    
    
    
 
    
    
    func getPurchaseInfo(){
        
        if SKPaymentQueue.canMakePayments() {
            
            let request = SKProductsRequest(productIdentifiers: NSSet(objects: self.ProductIDChat10) as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            self.showAlertViewWithSingleButton(title: "Warning", message: "Please enable in app purchase in the setting ")
            
        }
        
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        var products = response.products
        
        if products.count == 0 {
            
            self.showAlertViewWithSingleButton(title: "Warning", message: "Product Not Found.")
            
            
        } else {
            
            product  = products[0]
             
            purchasechat.isHidden = false
        }
        
        let invalids = response.invalidProductIdentifiers
        
        for product in invalids {
            
            self.showAlertViewWithSingleButton(title: "Warning", message: "\(product)")
            
            
        }
        
        
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch  transaction.transactionState {
            case SKPaymentTransactionState.purchased:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                self.showAlertViewWithSingleButton(title: "Thank You", message: "The Product has been purchased.")
             
                startChatSession()
                purchasechat.isHidden = true
                
              
                
              
            case SKPaymentTransactionState.failed:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                self.showAlertViewWithSingleButton(title: "Warning", message:"The Product not has been purchased.")
                
                
                
            default:
                break
            }
        }
        
    }
    
    func startChatSession(){
        startActivityIndicator()
        guard let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: ",") else {return}
        let ref = Database.database().reference().child("Live_Chat_Session").child(email)
        
        let values = ["session": "start"]
        ref.updateChildValues(values) { (error, ref) in
            
            if error != nil {
                
                self.showAlertViewWithSingleButton(title: "Warning", message: (error?.localizedDescription.description)!)
                return
            }
            self.stopActivityIndicator()
            
            self.showAlertViewWithSingleButton(title: "Welcome!", message: "Hey! Now you can chat with Dr. Puneet Chawla.")
        }
    }

    
   
}
