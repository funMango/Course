//
//  MemoSectionView.swift
//  YourCourse
//
//  Created by 이민호 on 3/23/24.
//

import SwiftUI
import ComposableArchitecture


struct MemoSectionView: View {
    let store: StoreOf<CourseFeature>
    let isFocused: FocusState<Bool>.Binding
    var memoPlaceholder = "메모"
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Section {
                MemoTextEditor(
                    content: viewStore.$course.memo,
                    placeholder: "메모",
                    isFocused: isFocused
                )
            }
        }
    }
}


