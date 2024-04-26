//
//  Event.swift
//  YourCourse
//
//  Created by 이민호 on 4/5/24.
//

import Foundation

struct Event: Codable, Hashable, Equatable, Identifiable {
    var id: String
    var title: String
    var location: String
    var memo: String
    var order: Int
    
    init(title: String = "", location: String = "", memo: String = "메모", order: Int = 0) {
        self.id = UUID().uuidString
        self.title = title
        self.location = location
        self.memo = memo
        self.order = order
    }
    
    mutating func setOrder(order: Int) {
        self.order = order
    }
}
