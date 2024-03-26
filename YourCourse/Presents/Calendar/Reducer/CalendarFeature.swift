//
//  CalendarFeature.swift
//  YourCourse
//
//  Created by 이민호 on 3/23/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct CalendarFeature: Reducer {
    struct State: Equatable {
        var courses: [Course] = []
    }
    
    enum Action {
        case fetchCoursesRequest
        case fetchCourseResponse([Course])
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchCoursesRequest:
                return .run { send in
                    let courses = try await firestoreAPIClient.fetchCourses()
                    await send(.fetchCourseResponse(courses))
                } catch: { error, send in
                    print(error)
                }
                
            case let .fetchCourseResponse(courses):
                state.courses = courses
                print("Courses: \(courses)")
                return .none
            }
        }
    }
}
