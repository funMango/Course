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
        case fetchEvent(String)
        case setEvent(Event)
        case resetEvent
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
                    await send(.resetEvent)
                } catch: { error, send in
                    print(error)
                }
            
            case let .fetchEvent(courseId):
                let eventId = state.event.id
                return .run { send in
                    for try await event in try await firestoreAPIClient.fetchEvent(courseId: courseId, eventId: eventId) {
                        await send(.setEvent(event))
                    }
                }
            
            case let .setEvent(event):
                state.event = event
                return .none
                
            case .resetEvent:
                state.event = Event()
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}

