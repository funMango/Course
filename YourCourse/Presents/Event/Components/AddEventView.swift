//
//  AddEventView.swift
//  YourCourse
//
//  Created by 이민호 on 4/5/24.
//

import SwiftUI
import ComposableArchitecture

struct AddEventView: View {
    @Binding var showAddEventView: Bool
    @FocusState var isFocused: Bool
    @State private var isPlusBtnDisable = true
    
    let store: StoreOf<EventFeature>
    let courseId: String
    let order: Int
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {                                        
                    Section {
                        InputTextFeild(
                            text: viewStore.$event.title,
                            title: "제목",
                            keyboardType: .default,
                            isFocused: $isFocused
                        )
                        
                        InputTextFeild(
                            text: viewStore.$event.location,
                            title: "위치",
                            keyboardType: .default,
                            isFocused: $isFocused
                        )
                    }
                    
                    Section {
                        MemoTextEditor(
                            content: viewStore.$event.memo,
                            placeholder: "메모",
                            isFocused: $isFocused
                        )
                    }
                }
                .onChange(of: viewStore.event.title) {
                    isPlusBtnDisable = viewStore.event.title.isEmpty ? true : false
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewStore.send(.tappedSaveButton(courseId, order))
                            showAddEventView.toggle()
                        } label: {
                            Text("추가")
                                .foregroundStyle(isPlusBtnDisable ? .gray : .red)
                        }
                        .disabled(isPlusBtnDisable)
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("새로운 이벤트")
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showAddEventView.toggle()
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

//#Preview {
//    AddEventView(
//        showAddEventView: .constant(false),
//        store: Store(
//            initialState: EventFeature.State(
//                course: Course(
//                    title: "Course",
//                    location: "Suwon",
//                    memo: "Testing...",
//                    startDate: Date(),
//                    endDate: Date(),
//                    color: .red
//                ), events: [
//                    Event(
//                        title: "서울여행",
//                        location: "서울특별시",
//                        memo: "서울 1박 2일 여행\n여행장소: 홍대, 강남, 광화문",
//                        order: 0
//                    )
//                ]
//            ),
//            reducer: { EventFeature() })
//        )
//}
