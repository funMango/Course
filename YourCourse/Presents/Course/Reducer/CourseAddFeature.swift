//
//  CourseFeature.swift
//  YourCourse
//
//  Created by 이민호 on 3/20/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct CourseAddFeature: Reducer {
    struct State: Equatable {
        @BindingState var course = Course()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case tappedAddButton
        case saveCourse
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedAddButton:
                if state.course.memo == "메모" {
                    state.course.memo = ""
                }
                return .send(.saveCourse)
            
            case .saveCourse:
                let course = state.course
                return .run { send in
                    try await firestoreAPIClient.saveCourse(course: course)
                } catch: { error, send in
                    print(error)
                }
                                                                                                
            case .binding:
                return .none
            }
        }
    }
}
