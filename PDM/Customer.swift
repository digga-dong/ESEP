//
//  Customer.swift
//  PDM
//
//  Created by HOLLEY on 15/11/4.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import Foundation
import ObjectMapper

class Customer : Mappable {
    
    var customerId : Int!
    var customerNo : String!
    var customerName : String!
    var address : String!
    var lastPurchaseTime : String!
    var meters : [Meter] = [Meter]()
    
    
//    init(customerId:String,customerNo:String,customerName:String){
//        self.customerId = customerId
//        self.customerNo = customerNo
//        self.customerName = customerName
//    }
    
    required init?(_ map: Map){
        customerId <- map["customerId"]
        customerNo <- map["customerNo"]
        customerName <- map["customerName"]
        address <- map["address"]
        lastPurchaseTime <- map["LastPurchaseTime"]
        meters <- map["_customerDs.meterList"]
    }
    
    // Mappable
    func mapping(map: Map) {
        customerId <- map["customerId"]
        customerNo <- map["customerNo"]
        customerName <- map["customerName"]
        address <- map["address"]
        lastPurchaseTime <- map["LastPurchaseTime"]
        meters <- map["_customerDs.meterList"]
    }
    
}