//
//  MonthOrder.swift
//  PDM
//
//  Created by HOLLEY on 15/11/11.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import Foundation
import ObjectMapper


class MonthOrder: Mappable {
    var Month : String!
    var Amount : Double!
    
    required init?(_ map: Map){
        Month <- map["month"]
        Amount <- map["amount"]
    }
    
    // Mappable
    func mapping(map: Map) {
        Month <- map["month"]
        Amount <- map["amount"]
    }
}