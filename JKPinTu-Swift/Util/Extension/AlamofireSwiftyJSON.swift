//
//  AlamofireSwiftyJSON.swift
//  AlamofireSwiftyJSON
//
//  Created by Pinglin Tang on 14-9-22.
//  Copyright (c) 2014 SwiftyJSON. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

// MARK: - Request for Swift JSON

extension Request {
    
    /**
     Adds a handler to be called once the request has finished.
     
     :param: completionHandler A closure to be executed once the request has finished. The closure takes 4 arguments: the URL request, the URL response, if one was received, the SwiftyJSON enum, if one could be created from the URL response and data, and any error produced while creating the SwiftyJSON enum.
     
     :returns: The request.
     */
    
    
//    、、jack wang
//    public func responseSwiftyJSON(completionHandler: @escaping (NSURLRequest, HTTPURLResponse?, SwiftyJSON.JSON, Error?) -> Void) -> Self {
//        return responseSwiftyJSON( options:JSONSerialization.ReadingOptions.allowFragments, completionHandler:completionHandler)
//    }
    
    /**
     Adds a handler to be called once the request has finished.
     
     :param: queue The queue on which the completion handler is dispatched.
     :param: options The JSON serialization reading options. `.AllowFragments` by default.
     :param: completionHandler A closure to be executed once the request has finished. The closure takes 4 arguments: the URL request, the URL response, if one was received, the SwiftyJSON enum, if one could be created from the URL response and data, and any error produced while creating the SwiftyJSON enum.
     
     :returns: The request.
     */
    
    
//    、、jack wang
//    public func responseSwiftyJSON( options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: @escaping (NSURLRequest, HTTPURLResponse?, JSON, Error?) -> Void) -> Self {
//        
//        
//        return  response(queue: nil, responseSerializer: Request.JSONResponseSerializer(options: options), completionHandler: { (request, response, result) -> Void in
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                var responseJSON: JSON
//                if result.isFailure
//                {
//                    responseJSON = JSON.null
//                } else {
//                    responseJSON = SwiftyJSON.JSON(result.value!)
//                }
//                dispatch_async(queue ?? dispatch_get_main_queue(), {
//                    completionHandler(self.request!, self.response, responseJSON, result.error)
//                })
//            })
//        })
//    }
}


