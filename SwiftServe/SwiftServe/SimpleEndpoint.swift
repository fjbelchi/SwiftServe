//
//  SimpleEndpoint.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/22/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class SimpleEndpoint:Router
{
    override func processRoutes(connection:Connection, parameters:Dictionary<NSObject,AnyObject>) -> Bool
    {
        
        if let id = parameters["id"] as? NSNumber
        {
            connection.response!.statusCode = StatusCode.OK
            
            let response = ["name":"Anthony", "answer":id, "keys":["asdf", "qwerty", "dvorak"] ]
            connection.setJSONResponseObject(response)
        }
        else
        {
            connection.response!.statusCode = StatusCode.BAD_REQUEST
            
            let response = ["message":"The id must be specified as numeric."]
            connection.setJSONResponseObject(response)
        }
        
        return true
    }
}