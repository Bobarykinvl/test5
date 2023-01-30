//
//  IAPManager.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 13.01.23.
//

import Foundation
import StoreKit

final class IAPManager: NSObject {
    
    static let shared = IAPManager()
    private override init() {}
    
    private var products: [SKProduct] = []
    private var invalidProductsID: [String] = []

    public func setupPurchases(callback: @escaping(Bool) -> ()) {
        if SKPaymentQueue.canMakePayments() {
            SKPaymentQueue.default().add(self)
            callback(true)
            return
        }
        callback(false)
    }
    
    public func getProducts() {
        let identifiers: Set = [
            IAPProducts.nonConsumable.rawValue,
            IAPProducts.consumable.rawValue
        ]
        
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self
        productRequest.start()
    }
}

// MARK: SKPaymentTransactionObserver
extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
}

// MARK: SKProductsRequestDelegate
extension IAPManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        invalidProductsID = response.invalidProductIdentifiers
        print("invalidProductIdentifiers \(invalidProductsID.count)")
        products.forEach { print("Name IAP \($0.debugDescription)")
        }
    }
}

