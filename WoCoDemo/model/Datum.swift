//
//  Datum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 20, 2020

import Foundation
import UIKit
import ObjectMapper

//MARK: - Datum
public struct Datum: Mappable,Codable {

    var count : String!
    var id : String!
    var isOnsite : String!
    var lat : String!
    var lng : String!
    var minRadius : String!
    var status : String!
    var title : String!
    var userId : String!
    var checkinTimestamp : String!
    var checkinLat : String!
    var checkinLng : String!
    var checkinType : String!
    var checkinComment : String!
    var checkinDate : String!
    var location : String!
    var siteType : String!
    var companyId : String!
    var accessToken : String!

    public init?(map: Map) {}
    init() {
    }
    mutating public func mapping(map: Map) {
       count <- map["count"]
       id <- map["id"]
       isOnsite <- map["is_onsite"]
       lat <- map["lat"]
       lng <- map["lng"]
       minRadius <- map["min_radius"]
       status <- map["status"]
       title <- map["title"]
        userId <- map["user_id"]
        checkinTimestamp <- map["checkin_timestamp"]
        checkinLat <- map["checkin_lat"]
        checkinLng <- map["checkin_lng"]
        checkinType <- map["checkin_type"]
        checkinComment <- map["checkin_comment"]
        checkinDate <- map["checkin_date"]
        location <- map["location"]
        siteType <- map["site_type"]
        companyId <- map["company_id"]
        accessToken <- map["access_token"]
    }

}
