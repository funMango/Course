//
//  Course.swift
//  YourCourse
//
//  Created by 이민호 on 3/22/24.
//

import Foundation
import FirebaseFirestore // Firestore를 사용하기 위해 필요

struct Course: Codable, Hashable {
    var id: String
    var title: String
    var location: String
    var memo: String
    var startDate: Date
    var endDate: Date
    
    init(title: String, location: String, memo: String, startDate: Date, endDate: Date) {
        self.id = UUID().uuidString
        self.title = title
        self.location = location
        self.memo = memo
        self.startDate = startDate
        self.endDate = endDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, location, memo, startDate, endDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        location = try container.decode(String.self, forKey: .location)
        memo = try container.decode(String.self, forKey: .memo)
        
        let startDateTimestamp = try container.decode(Timestamp.self, forKey: .startDate)
        startDate = startDateTimestamp.dateValue()
        
        let endDateTimestamp = try container.decode(Timestamp.self, forKey: .endDate)
        endDate = endDateTimestamp.dateValue()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(location, forKey: .location)
        try container.encode(memo, forKey: .memo)
        
        let startDateTimestamp = Timestamp(date: startDate)
        try container.encode(startDateTimestamp, forKey: .startDate)
        
        let endDateTimestamp = Timestamp(date: endDate)
        try container.encode(endDateTimestamp, forKey: .endDate)
    }
}

