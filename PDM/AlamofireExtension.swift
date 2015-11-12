//
//  AlamofireExtension.swift
//  PDM
//
//  Created by HOLLEY on 15/11/4.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import Foundation
import Alamofire


public protocol ResponseCollectionSerializable {
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
}

extension Alamofire.Request {
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let response = response {
                    return .Success(T.collection(response: response, representation: value))
                } else {
                    let failureReason = "Response collection could not be serialized due to nil response"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}


public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: AnyObject)
}


extension Alamofire.Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let
                    response = response,
                    responseObject = T(response: response, representation: value)
                {
                    return .Success(responseObject)
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://172.16.24.77/hdm/api/UAPP"
    //static let baseURLString = "http://172.28.61.1:9999/api/UAPP"
    
    case GetMeterList(Int,String)
    case CustomerLogin(String,String)
    case GetPrepayOrderList(Int,Int,Int)
    case GetPrepayOrderAmountByMonth(Int)
    case GetConsumptionAmountByMonth(Int)
    case GetBillingDataList(Int,Int,Int)
    
    var URLRequest: NSMutableURLRequest {
        get{
            let (path, parameters): (String, [String: AnyObject]) = {
                switch self {
                case .GetMeterList (let pageIndex, let keyword):
                    let params = ["pageIndex": "\(pageIndex)", "keyword": "\(keyword)"]
                    return ("/getMeterList", params)
                    
                case .CustomerLogin(let customerNo, let customerPwd):
                    let params = ["customerNo": "\(customerNo)", "password": "\(customerPwd)"]
                    return ("/customerLogin",params)
                
                
                case .GetPrepayOrderList(let customerId, let pageIndex, let pageCount):
                    let params = ["customerId": "\(customerId)", "pageIndex": "\(pageIndex)", "pageCount": "\(pageCount)"]
                    return ("/getPrepayOrderList",params)
                    
                case .GetPrepayOrderAmountByMonth(let customerId):
                    let params = ["customerId": "\(customerId)"]
                    return ("/getPrepayOrderAmountByMonth",params)
                    
                case .GetConsumptionAmountByMonth(let meterId):
                    let params = ["meterId": "\(meterId)"]
                    return ("/getConsumptionAmountByMonth",params)
                    
                case .GetBillingDataList(let meterId, let pageIndex, let pageCount):
                    let params = ["meterId": "\(meterId)", "pageIndex": "\(pageIndex)", "pageCount": "\(pageCount)"]
                    return ("/getBillingDataList",params)
                
                }
                
                
            }()
            
            let URL = NSURL(string: Router.baseURLString)
            let URLRequest = NSURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            let encoding = Alamofire.ParameterEncoding.URL
            
            print(encoding.encode(URLRequest, parameters: parameters).0)
            
            return encoding.encode(URLRequest, parameters: parameters).0
        }
        
    }
}

