//
//  ChangeCourseView.swift
//  YourCourse
//
//  Created by 이민호 on 4/11/24.
//

import SwiftUI
import ComposableArchitecture

struct ChangeCourseView: View {
    let store: StoreOf<CourseDetailFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
        }
        .toolbar() {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Text("저장")
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

//#Preview {
//    ChangeCourseView(
//        store: Store(
//            initialState: CourseDetailFeature.State(course:
//                    Course(
//                        title: "도쿄여행",
//                        location: "도쿄",
//                        memo: "아시아나항공(나리타) 10:30 온보딩 \n대한항공(인천) 12:45 온보딩",
//                        startDate: Date(),
//                        endDate: Date(),
//                        color: .red
//                    )
//                ),
//            reducer: { CourseDetailFeature() }
//        )
//    )
//}
