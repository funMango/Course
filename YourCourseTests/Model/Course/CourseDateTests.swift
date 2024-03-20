//
//  DayTests.swift
//  YourCourseTests
//
//  Created by 이민호 on 3/20/24.
//

import XCTest
@testable import YourCourse

final class CourseDateTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_formatDateToString() throws {
        let testcases: [(year: Int, month: Int, day: Int, expected: String)] = [
            (2023, 3, 24, "2023.03.24"),
            (2021, 1, 1, "2021.01.01"),
            (2024, 12, 31, "2024.12.31"),
            (2024, 0, 31, "2023.12.31"), // 0이 들어가면 -1이 되어 2023.12.31이 된다.
            (0, 1, 1, "0001.01.01") // 0001.01.01이 된다.
        ]
        
        for testcase in testcases {
            let calendar = Calendar.current
            var components = DateComponents()
            components.year = testcase.year
            components.month = testcase.month
            components.day = testcase.day
            
            
            
            if let specificDate = calendar.date(from: components) {
                print(specificDate, testcase.expected)
                let date = CourseDate(date: specificDate)
                XCTAssertEqual(
                    testcase.expected,
                    date.formatDateToString(),
                    "CourseDate의 formatDateToString 기능 테스트에 실패하였습니다."
                )
            } else {
                XCTAssertEqual(
                    testcase.expected,
                    "Invalid Date",
                    "유효하지 않은 값 입니다."
                )
            }
        }
    }
}
