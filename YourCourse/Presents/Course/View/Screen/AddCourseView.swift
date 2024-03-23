//
//  AddCourseView.swift
//  YourCourse
//
//  Created by 이민호 on 3/16/24.
//

import SwiftUI
import ComposableArchitecture

struct AddCourseView: View {
    @Binding var showAddCourseView: Bool
    @FocusState private var isFocused: Bool
    @State private var isPlusBtnDisable = true
    let store: StoreOf<CourseFeature>
    var memoPlaceholder = "메모"
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    TitleLocationSectionView(store: self.store, isFocused: $isFocused)
                    
                    DateSectionView(store: self.store)
                                        
                    Section {
                        TextEditor(text: viewStore.$memo)
                            .foregroundColor(viewStore.memo == memoPlaceholder ? .gray : .primary)
                            .cornerRadius(15)
                            .frame(minHeight: 200, maxHeight: 300)
                            .focused($isFocused)
                            .autocorrectionDisabled()
                            .onTapGesture {
                                if viewStore.memo == memoPlaceholder {
                                    viewStore.send(.resetMemo)
                                }
                            }
                    }
                }
                .onChange(of: viewStore.$isSavedCourse) { _ in
                    if viewStore.isSavedCourse {
                        showAddCourseView = false
                    }
                }
                .onChange(of: viewStore.$title) { _ in
                    isPlusBtnDisable = viewStore.title.isEmpty ? true : false
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            viewStore.send(.tappedAddButton)
                        } label: {
                            Text("추가")
                        }
                        .disabled(isPlusBtnDisable)
                    }
                    
                    ToolbarItemGroup(placement: .principal) {
                        Text("새로운 코스")
                    }
                    
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button {
                            showAddCourseView.toggle()
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

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseView(showAddCourseView: .constant(true),
                      store: Store(
                        initialState: CourseFeature.State(),
                        reducer: { CourseFeature() })
        )
    }
}
