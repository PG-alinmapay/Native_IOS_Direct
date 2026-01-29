//
//  UWInitializer.swift
//  directpg
//
//  Created by Runali on 10/10/24.
//


import Foundation
import UIKit
import PassKit

public enum pickerType: String {
    case add = "Add"
    case update = "Update"
    case delete = "Delete"
    
    func getValue() -> String {
        switch self {
        case .add:
            return "A"
        case .update:
            return "U"
        case .delete:
            return "D"
        }
    }
}

public class UWInitializer {
    
    // MARK: - Required
    public let amount: String
    public let email: String
    public let currency: String
    public let country: String
    public let actionCode: String
    public let trackIdCode: String
    public let isApplePay: String
    
    // MARK: - Optional / Configurable
    public let zipCode: String?
    public let city: String?
    public let address: String?
    public let state: String?
    public let transid: String?
    
    
  
    
    // MARK: - Card / Token
    public let cardToken: String?
    public let cardOperation: String
    public let merchantIdentifier: String?
    public var paymentTokenString: String? = nil
    public let cvv: String?
    public let cardNumber: String?
    public let expMonth: String?
    public let expYear: String?
    public let cardholderName: String?
    
    
    // MARK: - Metadata
    public let metaData: String?
    
    public init(
        amount: String ,
        email: String ,
        zipCode: String? = nil ,
        currency: String ,
        country: String ,
        actionCode: String,
        trackIdCode: String,
        
        city: String? = nil ,
        address: String? = nil,
        state: String? = nil,
        transid: String? = nil,
        merchantIdentifier: String? = nil,
        isApplePay: String,
        cardToken: String? = nil,
        cardOper: String,
        
        
        cardNumber: String? = nil,
        cvv: String? = nil,
        expMonth: String? = nil,
        expYear: String? = nil,
        holderName: String? = nil,
        paymentTokenString: String? = nil,
        metaData:String? = nil
        
    ){
        
        self.amount = amount
        self.email = email
        self.zipCode = zipCode
        self.currency = currency
        self.country = country
        self.actionCode = actionCode
        self.trackIdCode = trackIdCode
      
        self.state = state
        self.city = city
        self.address = address
        
        self.cardToken = cardToken
        self.cardOperation = cardOper
        //self.state = state
        
        
        self.transid=transid
        self.merchantIdentifier = merchantIdentifier
        self.cardNumber = cardNumber
        self.cvv = cvv
        self.expMonth = expMonth
        self.expYear = expYear
        self.cardholderName = holderName
        self.isApplePay = isApplePay
        self.paymentTokenString = paymentTokenString
        self.metaData = metaData
    }
}
// MARK: - Apple Pay Helper
extension UWInitializer {
    public static func generatePaymentKey(payment: PKPayment) -> [String: Any] {

        let paymentDataJSON = try? JSONSerialization.jsonObject(
                   with: payment.token.paymentData,
                   options: []
               ) as? [String: Any]
        let method = payment.token.paymentMethod

        return [
            "paymentData": paymentDataJSON,
            "paymentMethod": [
                "displayName": method.displayName ?? "",
                "network": method.network?.rawValue ?? "",
                "type": "debit"
            ],
            "transactionIdentifier": payment.token.transactionIdentifier
        ]
    }

}


