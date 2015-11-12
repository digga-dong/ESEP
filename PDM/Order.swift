//
//  Order.swift
//  PDM
//
//  Created by HOLLEY on 15/11/4.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import Foundation
import ObjectMapper

class Order: Mappable {
    var orderNo : String!
    var orderTime : String!
    var totalPayAmount : CGFloat!
    
    required init?(_ map: Map){
        orderNo <- map["ORDER_ID"]
        orderTime <- map["ORDER_TIME"]
        totalPayAmount <- map["TOTALPAYAMOUNT"]
    }
    
    // Mappable
    func mapping(map: Map) {
        orderNo <- map["ORDER_ID"]
        orderTime <- map["ORDER_TIME"]
        totalPayAmount <- map["TOTALPAYAMOUNT"]
    }
}
