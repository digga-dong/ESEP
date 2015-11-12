//
//  MonthEnergy.swift
//  PDM
//
//  Created by HOLLEY on 15/11/11.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import Foundation
import ObjectMapper


class MonthConsumption: Mappable {
    var Month : String!
    var ConsumptionkWh : Double!
    var ConsumptionMoney : Double!
    var Balance : Double!
    
    required init?(_ map: Map){
        Month <- map["month"]
        ConsumptionkWh <- map["BillingConsumption"]
        ConsumptionMoney <- map["BillingMoney"]
        Balance <- map["ResidualMoney"]
    }
    
    // Mappable
    func mapping(map: Map) {
        Month <- map["month"]
        ConsumptionkWh <- map["BillingConsumption"]
        ConsumptionMoney <- map["BillingMoney"]
        Balance <- map["ResidualMoney"]
    }
}