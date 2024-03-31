//
//  Course.swift
//  YourCourse
//
//  Created by 이민호 on 3/22/24.
//

import Foundation
import FirebaseFirestore

struct Course: Codable, Hashable {
    var id: String
    var title: String
    var location: String
    var memo: String
    var startDate: Date
    var endDate: Date
    var color: CourseColor
    
    init(title: String, location: String, memo: String, startDate: Date, endDate: Date, color: CourseColor) {
        self.id = UUID().uuidString
        self.title = title
        self.location = location
        self.memo = memo
        self.startDate = startDate
        self.endDate = endDate
        self.color = color
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, location, memo, startDate, endDate, color
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
        
        color = try container.decode(CourseColor.self, forKey: .color)
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
        
        try container.encode(color, forKey: .color)
    }
}

