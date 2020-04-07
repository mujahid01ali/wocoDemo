//
//  RecentVisitResponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 20, 2020

import Foundation
import UIKit
import ObjectMapper

//MARK: - RecentVisitResponse
public struct RecentVisitResponse: Mappable,Codable {

    var data : [Datum]!
    var message : String!
    var status : Int!
    public init?(map: Map) {}
    init() {}
    mutating public func mapping(map: Map) {
       data <- map["data"]
       message <- map["message"]
       status <- map["status"]
    }

}
