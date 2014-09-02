//
//  Lift.swift
//  lift
//
//  Created by Kevin Jenkins on 8/6/14.
//  Copyright (c) 2014 somethingPointless. All rights reserved.
//

import Foundation


class Lift {

    class func asyncSend(request: NSURLRequest, block: (data: [String:AnyObject]?, error: NSError) -> Void) {

        [NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in

            if (error) {
                block(data: nil, error: error)
                return
            }

            var jsonError: NSErrorPointer?
            var json: [String: AnyObject]! = Lift.dictionaryFromJSONData(data, jsonError: jsonError)


            if let e = jsonError {
                block(data: nil, error: e.memory!)
                return
            }

            block(data: json, error: error)

        }];
    }

    class func syncSend(request: NSURLRequest, error: NSError) -> [String: AnyObject] {

        var response: NSURLResponse?
        var error: NSError?

        var data: NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)

        if let e = error {
            return [:]
        }

        var jsonError: NSErrorPointer?
        var responseData: [String: AnyObject] = Lift.dictionaryFromJSONData(data, jsonError: jsonError)

        if let e = jsonError {
            error = jsonError?.memory
            return [:]
        }

        return responseData
    }

    class func dictionaryFromJSONData(data: NSData, jsonError: NSErrorPointer?) -> [String: AnyObject] {

        var json: [String: AnyObject]! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: jsonError!) as [String: AnyObject]
        return json;
    }

}
