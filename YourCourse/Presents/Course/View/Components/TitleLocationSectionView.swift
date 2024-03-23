//
//  TitleLocationSectionView.swift
//  YourCourse
//
//  Created by 이민호 on 3/23/24.
//

import SwiftUI
import ComposableArchitecture

struct TitleLocationSectionView: View {
    let store: StoreOf<CourseFeature>
    let isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Section {
                TextField("제목",text: viewStore.$title)
                    .keyboardType(.default)
                    .autocorrectionDisabled()
                    .focused(isFocused)
                
                TextField("위치",text: viewStore.$location)
                    .keyboardType(.default)
                    .autocorrectionDisabled()
                    .focused(isFocused)
            }                                                        
        }
    }
}

