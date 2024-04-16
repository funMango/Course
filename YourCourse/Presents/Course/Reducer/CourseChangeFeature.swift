//
//  CourseChangeFeature.swift
//  YourCourse
//
//  Created by 이민호 on 4/12/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct CourseChangeFeature: Reducer {
    struct State: Equatable {        
        @BindingState var course: Course
        
    }
    
    enum Action: BindableAction {
        case tappedSaveBtn
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedSaveBtn:
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
