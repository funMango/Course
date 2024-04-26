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
        @BindingState var event = Event()
    }
    
    enum Action: BindableAction {
        case tappedSaveButton(String, Int)
        case setEvent
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case let .tappedSaveButton(courseId, order):
                state.event.setOrder(order: order)
                let event = state.event
                
                return .run { send in
                    try await firestoreAPIClient.saveEvent(courseId: courseId, event: event)
                    await send(.setEvent)
                } catch: { error, send in
                    print(error)
                }
                
            case .setEvent:
                state.event = Event()
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}

