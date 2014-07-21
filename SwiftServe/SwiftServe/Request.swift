//
//  Request.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class Request:Printable
{
    let message:CFHTTPMessage
    let headersNSDictionary:NSDictionary
    
    var headers = Dictionary<String, String>()
    
    init(data:NSData)
    {
        message = CFHTTPMessageCreateEmpty(nil, 1).takeRetainedValue()
        CFHTTPMessageAppendBytes(message, data.byteDataAsUInt8(), data.length)
        
        headersNSDictionary = CFHTTPMessageCopyAllHeaderFields(message).takeUnretainedValue()
        parseHeaders()
    }
    
    func appendRequestData(data:NSData)
    {
        CFHTTPMessageAppendBytes(message, data.byteDataAsUInt8(), data.length)
    }
    
    func parseHeaders()
    {
        for (key : AnyObject, value : AnyObject) in headersNSDictionary
        {
            headers[key as String] = value as? String
//            println("\(key): \(value)")
        }
        
        CFRelease(headersNSDictionary)
    }
    
    var httpMethod:String
    {
        return CFHTTPMessageCopyRequestMethod(message).takeUnretainedValue()
    }
    
    var url:NSURL
    {
        return CFHTTPMessageCopyRequestURL(message).takeUnretainedValue()
    }
    
    var version:String
    {
        return CFHTTPMessageCopyVersion(message).takeUnretainedValue()
    }
    
    var data:NSData
    {
        return CFHTTPMessageCopyBody(message).takeUnretainedValue()
    }
    
    func value(forHeaderKey key:HeaderKey) -> String?
    {
        return headers[key.toRaw()];
    }
    
    var description:String
    {
        return "\(httpMethod) \(url.path) \(version)"
    }
    
    deinit
    {
        CFRelease(message)
    }
}