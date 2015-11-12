//
//  Meter.swift
//  PDM
//
//  Created by HOLLEY on 15/11/4.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import Foundation
import ObjectMapper


class Meter : Mappable {
    var meterId : Int!
    var meterNo : String!
    var commAddr : String!
    
    required init?(_ map: Map){
        meterId <- map["METER_ID"]
        meterNo <- map["METER_NO"]
        commAddr <- map["COMMADDR"]
    }
    
    // Mappable
    func mapping(map: Map) {
        meterId <- map["METER_ID"]
        meterNo <- map["METER_NO"]
        commAddr <- map["COMMADDR"]
    }
}