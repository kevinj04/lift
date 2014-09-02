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

            var jsonError: NSError?
            var json: [String: AnyObject]! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as [String: AnyObject]

            if let e = jsonError {
                block(data: nil, error: e)
                return
            }

            block(data: json, error: error)

        }];
    }

}
