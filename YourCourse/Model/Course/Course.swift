//
//  Course.swift
//  YourCourse
//
//  Created by 이민호 on 3/22/24.
//

import Foundation

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
}
