//
//  Child.swift
//  YourCourse
//
//  Created by 이민호 on 4/26/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct Child {
    struct State: Equatable {
        var name: String
    }
    
    enum Action {
        case setName(String)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .setName(name):
                state.name = name
                return .none
            }
        }
    }
}
