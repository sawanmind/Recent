//
//  ViewController.swift
//  inapp
//
//  Created by Sawkan Team on 27/06/17.
//  Copyright © 2017 Sawkan Team. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController , SKPaymentTransactionObserver, SKProductsRequestDelegate{

    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var banner: UIButton!
    @IBOutlet weak var purchase: UIButton!
    
    @IBOutlet weak var restore: UIButton!
    
    
    
    var product : SKProduct?
    var ProductID = "com.sawkanInternet.inapp.UnlockReport"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        purchase.isEnabled = false
        SKPaymentQueue.default().add(self)
        getPurchaseInfo()
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let save = UserDefaults.standard
        if save.value(forKey: "Purchase") == nil {
            
            banner.isHidden = false
        } else {
            
            banner.isHidden = true
        }
    }
 


    @IBAction func purchasebtn(_ sender: Any) {
    
    let payment = SKPayment(product: product!)
    SKPaymentQueue.default().add(payment)
        
    
    
    }
    
    
    @IBAction func restorebtn(_ sender: Any) {
        
        SKPaymentQueue.default().restoreCompletedTransactions()
        
        
        
    }
    
    
    
    func getPurchaseInfo(){
        
        if SKPaymentQueue.canMakePayments() {
            
            let request = SKProductsRequest(productIdentifiers: NSSet(objects: self.ProductID) as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            
            titles.text = "Warning"
            desc.text = "Please enable in app purchase in the setting "
        }
        
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        var products = response.products
        
        if products.count == 0 {
            
            titles.text = "Warning"
            desc.text = "Product Not Found."
            
        } else {
            
            product  = products[0]
            titles.text = product!.localizedTitle
            desc.text = product!.localizedDescription
             purchase.isEnabled = true
        }
        
        let invalids = response.invalidProductIdentifiers
        
        for product in invalids {
            
            print("Product Not found \(product)")
            
            
        }
        
        
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch  transaction.transactionState {
            case SKPaymentTransactionState.purchased:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                titles.text = "Thank You"
                desc.text = "The Product has been purchased."
                purchase.isEnabled = false
                
                
                let save = UserDefaults.standard
                save.set(true, forKey: "Purchase")
                save.synchronize()
             
                
            case SKPaymentTransactionState.restored:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                titles.text = "Thank You"
                desc.text = "Your purchased product has been restored."
                purchase.isEnabled = false
                
                
                let save = UserDefaults.standard
                save.set(true, forKey: "Purchase")
                save.synchronize()
                
                
                
                
            case SKPaymentTransactionState.failed:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                titles.text = "Warning"
                desc.text = "The Product not has been purchased."
                
                
            default:
                break
            }
        }
        
    }
    
}















