//
//  EventChangeView.swift
//  YourCourse
//
//  Created by 이민호 on 5/2/24.
//

import SwiftUI
import ComposableArchitecture

struct EventChangeView: View {
    @Binding var showEvnetChangeView: Bool
    @FocusState var isFocused: Bool
    @State var isSaveBtnDisable = false
    let store: StoreOf<EventFeature>
    let courseId: String
    
    
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
                    isSaveBtnDisable = viewStore.event.title.isEmpty ? true : false
                }
                .toolbar() {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewStore.send(.tappedSaveButton(courseId, viewStore.event.order))
                            showEvnetChangeView.toggle()
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
                            showEvnetChangeView.toggle()
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
    EventChangeView(
        showEvnetChangeView: .constant(false),
        store:
            Store(
                initialState: EventFeature.State(
                    event: Event(
                        title: "카페가기",
                        location: "성수동",
                        memo: "성수역 2번출구"
                    )
                ),
                reducer: { EventFeature() }
            ), 
        courseId: ""
    )
}
