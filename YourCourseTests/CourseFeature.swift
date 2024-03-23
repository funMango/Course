//
//  CourseFeature.swift
//  YourCourse
//
//  Created by 이민호 on 3/20/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct CourseFeature: Reducer {
    struct State: Equatable {
        @BindingState var title = ""
        @BindingState var location = ""
        @BindingState var memo = "메모"
        @BindingState var isSavedCourse = false
        var startDate = Date.now
        var endDate = Date.now
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case setStartDate(Date)
        case setEndDate(Date)
        case resetMemo        
        case tappedAddButton
        case courseSavedSuccessfully
       
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedAddButton:
                let course = Course(
                    title: state.title,
                    location: state.location,                    
                    memo: state.memo,
                    startDate: state.startDate,
                    endDate: state.endDate
                )
                return .run { send in
                    try await firestoreAPIClient.saveCourse(course: course)
                    await send(.courseSavedSuccessfully)
                } catch: { error, send in
                    print(error)
                }
                
            case .courseSavedSuccessfully:                
                state.isSavedCourse.toggle()
                return .none
            
            case let .setStartDate(date):
                state.startDate = date
                return .none
                
            case let .setEndDate(date):
                state.endDate = date
                return .none
                
            case .resetMemo:
                state.memo = ""
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}
