//
//  ChekinReponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on April 7, 2020

import Foundation
import UIKit
import ObjectMapper

//MARK: - ChekinReponse
public struct ChekinReponse: Mappable,Codable {

    var status : Int!
    var message : String!
    var data : Datum!
    public init?(map: Map) {}
    init() {
    }
    mutating public func mapping(map: Map) {
       status <- map["status"]
       message <- map["message"]
       data <- map["data"]
    }

}
