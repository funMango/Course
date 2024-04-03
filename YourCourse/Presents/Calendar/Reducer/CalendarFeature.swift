//
//  CalendarFeature.swift
//  YourCourse
//
//  Created by 이민호 on 3/23/24.
//

import Foundation
import ComposableArchitecture
import SwiftUICalendar
import Dependencies
import Combine
import SwiftUI

struct CalendarFeature: Reducer {
    struct State: Equatable {
        @BindingState var courses: [Course] = []          
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case coursesLoaded([Course])
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    for try await courses in try await firestoreAPIClient.fetchCourses() {
                        await send(.coursesLoaded(courses))
                    }
                } catch: { error, send in
                    print(error)
                }
            case let .coursesLoaded(courses):
                print(courses.count)
                state.courses = courses
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}
