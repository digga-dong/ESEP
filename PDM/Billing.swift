//
//  Billing.swift
//  PDM
//
//  Created by HOLLEY on 15/11/11.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import Foundation
import ObjectMapper

class Billing: Mappable {
    var Time : String!
    var ConsumptionkWh : String!
    var ConsumptionMoney : String!
    var Balance : String!
    
    required init?(_ map: Map){
        Time <- map["DATE_TIME"]
        ConsumptionkWh <- map["BillingConsumption"]
        ConsumptionMoney <- map["BillingMoney"]
        Balance <- map["ResidualMoney"]
    }
    
    // Mappable
    func mapping(map: Map) {
        Time <- map["DATE_TIME"]
        ConsumptionkWh <- map["BillingConsumption"]
        ConsumptionMoney <- map["BillingMoney"]
        Balance <- map["ResidualMoney"]
    }
}