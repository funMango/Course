//
//  DateSectionView.swift
//  YourCourse
//
//  Created by 이민호 on 3/23/24.
//

import SwiftUI
import ComposableArchitecture

struct DateSectionView: View {
    let store: StoreOf<CourseFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in            
            Section {
                DatePicker(
                    selection: viewStore.binding(
                        get: \.startDate,
                        send: CourseFeature.Action.setStartDate
                    ),
                    in: Date()...,
                    displayedComponents: .date
                ) {
                    Text("시작")
                }
                
                DatePicker(
                    selection: viewStore.binding(
                        get: \.endDate,
                        send: CourseFeature.Action.setEndDate
                    ),
                    in: viewStore.startDate...,
                    displayedComponents: .date
                ) {
                    Text("종료")
                }
            }
        }
    }
}

#Preview {
    DateSectionView(store: Store(
        initialState: CourseFeature.State(),
        reducer: { CourseFeature() }
    ))
}
