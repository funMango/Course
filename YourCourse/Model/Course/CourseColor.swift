//
//  CourseColor.swift
//  YourCourse
//
//  Created by 이민호 on 3/31/24.
//

import Foundation

enum CourseColor: String, Codable {
    case red = "ff0000"
    case blue = "0471c2"
    case yellow = "ffd966"
    case brown = "783f04"
    case navy = "0E2144"
    case purple = "B4A7D6" // 오타 수정: "puple" -> "purple"
    
    func getColorName() -> String {
        switch self {
        case .red:
            return "빨간색"
        case .blue:
            return "파란색"
        case .yellow:
            return "노란색"
        case .brown:
            return "갈색"
        case .navy:
            return "남색"
        case .purple:
            return "보라색"
        }
    }
}
