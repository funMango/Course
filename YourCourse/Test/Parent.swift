//
//  Parent.swift
//  YourCourse
//
//  Created by 이민호 on 4/26/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct Parent {
    struct State: Equatable {
        var number = 1
        var child: Child.State?
    }
    
    enum Action {
        case setNumber
        case child(Child.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .setNumber:
                state.number = 1
                return .none
            case .child(_):
                return.none
            }
         }
         .ifLet(\.child, action: /Action.child) {
           Child()
         }
      }
}
