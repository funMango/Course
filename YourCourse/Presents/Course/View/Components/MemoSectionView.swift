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
                TextEditor(text: viewStore.$memo)
                    .foregroundColor(viewStore.memo == memoPlaceholder ? Color(hex: "#D3D3D5") : .primary)
                    .cornerRadius(15)
                    .frame(minHeight: 200, maxHeight: 300)
                    .focused(isFocused)
                    .autocorrectionDisabled()
                    .onTapGesture {
                        if viewStore.memo == memoPlaceholder {
                            viewStore.send(.resetMemo)
                        }
                    }
            }
        }
    }
}


