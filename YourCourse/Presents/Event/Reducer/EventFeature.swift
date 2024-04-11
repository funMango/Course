//
//  EventFeature.swift
//  YourCourse
//
//  Created by 이민호 on 4/5/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct EventFeature: Reducer {
    struct State: Equatable {
        @BindingState var course: Course
        @BindingState var events: [Event]
        @BindingState var title = ""
        @BindingState var location = ""
        @BindingState var memo = "메모"
    }
    
    enum Action: BindableAction {
        case tappedSaveButton
        case eventSavedSuccessfully        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedSaveButton:
                let event = Event(
                    title: state.title,
                    location: state.location,
                    memo: state.memo, 
                    order: state.events.count
                )
                let id = state.course.id
                
                return .run { send in
                    try await firestoreAPIClient.saveEvent(courseId: id, event: event)
                    await send(.eventSavedSuccessfully)
                } catch: { error, send in
                    print(error)
                }
                
            case .eventSavedSuccessfully:
                print("Event가 성공적으로 저장되었습니다.")
                state.title = ""
                state.location = ""
                state.memo = "메모"
                return .none
                                                                                   
            case .binding:
                return .none
            }
        }
    }
}

