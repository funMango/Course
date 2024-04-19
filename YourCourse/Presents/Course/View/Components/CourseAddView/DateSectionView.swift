//
//  DateSectionView.swift
//  YourCourse
//
//  Created by 이민호 on 3/23/24.
//

import SwiftUI
import ComposableArchitecture

struct DateSectionView: View {
    @State var showStartDateCalendar = false
    @State var showEndDateCalendar = false
    let store: StoreOf<CourseFeature>
    
    private var animation: Animation {
        .easeInOut(duration: 0.1)
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Section {
                DateSelectorView(
                    showCalendar: $showStartDateCalendar,
                    type: .start,
                    store: self.store
                )
                
                DateSelectorView(
                    showCalendar: $showEndDateCalendar,
                    type: .end,
                    store: self.store
                )                
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
