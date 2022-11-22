//
//  ListModel.swift
//  Fahad Test
//
//  Created by Fahad Shafiq on 21/11/2022.
//

import Foundation

class ListModel: Decodable {
    var id: String?
    var schedule: ConversionResponseModel?
    var name: String?
    var imageURL: String?
    var isCentred = false
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case schedule = "schedule"
        case name = "name"
        case imageURL = "visualAidUrl"
    }
}

struct ConversionResponseModel: Decodable {
    typealias DayKey = String
    
    let day : DayKey
    let time : String
    var dayTime = [String:String]()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dict = try container.decode([String:String].self)
        guard let key = dict.keys.first else {
            throw NSError(domain: "Decoder", code: 0, userInfo: [:])
        }
        
        for i in dict {
            dayTime[i.key] = i.value
        }
        
        day = key
        time = dict[key] ?? ""
    }
}
