//
//  ChangeCourseView.swift
//  YourCourse
//
//  Created by 이민호 on 4/11/24.
//

import SwiftUI
import ComposableArchitecture

struct CourseChangeView: View {
    @Binding var showChangeCourseView: Bool    
    @State var isSaveBtnDisable = false
    @State var showStartDateCalendar = false
    @State var showEndDateCalendar = false
    @FocusState var isFocused: Bool
    let store: StoreOf<CourseFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {                    
                    TitleLocationSectionView(
                        store: self.store,
                        isFocused: $isFocused
                    )
                                        
                    DateSectionView(store: self.store)
                                                        
                    Section {
                        EventList(
                            store: self.store.scope(
                                state: \.eventsFeature,
                                action: \.eventsFeature
                            ), 
                            coursId: viewStore.course.id
                        )
                    }
                    
                    MemoSectionView(store: self.store, isFocused: $isFocused)
                    
                    ColorSectionView(store: self.store)
                }
                .onChange(of: viewStore.course.title) {
                    isSaveBtnDisable = viewStore.course.title.isEmpty ? true : false                    
                }
                .toolbar() {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewStore.send(.tappedSaveButton)
                            showChangeCourseView.toggle()
                        } label: {
                            Text("저장")
                                .foregroundStyle(isSaveBtnDisable ? .gray : .red)
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("코스 수정")
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showChangeCourseView.toggle()
                        } label: {
                            Text("취소")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }              
        }
    }
}

#Preview {
    CourseChangeView(
        showChangeCourseView: .constant(false),
        store: Store(
            initialState: CourseFeature.State(course:
                    Course(
                        title: "도쿄여행",
                        location: "도쿄",
                        memo: "아시아나항공(나리타) 10:30 온보딩 \n대한항공(인천) 12:45 온보딩",
                        startDate: Date(),
                        endDate: Date(),
                        color: .red
                    )
                ),
            reducer: { CourseFeature() }
        )
    )
}
