//
//  CourseFeature.swift
//  YourCourse
//
//  Created by 이민호 on 3/20/24.
//

import Foundation
import ComposableArchitecture


struct CourseFeature: Reducer {
    struct State: Equatable {
        @BindingState var title = ""
        @BindingState var location = ""
        @BindingState var isAllDay = false
        @BindingState var memo = "메모"
        var startDate = Date.now
        var endDate = Date.now
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case setStartDate(Date)
        case setEndDate(Date)
        case resetMemo
        case tappedAddButton
        
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedAddButton:
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
