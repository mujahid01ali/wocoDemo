//
//  BaseResponse.swift
//  WoCoDemo
//
//  Created by Mujahid on 07/04/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

//MARK: - BaseResponse
public struct BaseResponse: Mappable,Codable {

    var message : String!
    var status : Int!
    public init?(map: Map) {}
    init() {}
    mutating public func mapping(map: Map) {
       message <- map["message"]
       status <- map["status"]
    }

}
