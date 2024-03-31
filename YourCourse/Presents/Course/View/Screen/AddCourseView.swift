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
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    TitleLocationSectionView(store: self.store, isFocused: $isFocused)
                    
                    DateSectionView(store: self.store)
                                        
                    MemoSectionView(store: self.store, isFocused: $isFocused)
                    
                    ColorSectionView(store: self.store)
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
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewStore.send(.tappedAddButton)
                        } label: {
                            Text("추가")
                        }
                        .disabled(isPlusBtnDisable)
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("새로운 코스")
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showAddCourseView.toggle()
                        } label: {
                            Text("취소")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
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
