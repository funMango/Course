//
//  TitleLocationSectionView.swift
//  YourCourse
//
//  Created by 이민호 on 3/23/24.
//

import SwiftUI
import ComposableArchitecture

struct TitleLocationSectionView: View {
    let store: StoreOf<CourseAddFeature>
    let isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Section {
                InputTextFeild(
                    text: viewStore.$course.title,
                    title: "제목",
                    keyboardType: .default,
                    isFocused: isFocused
                )
                
                InputTextFeild(
                    text: viewStore.$course.location,
                    title: "위치",
                    keyboardType: .default,
                    isFocused: isFocused
                )                                                
            }                                                        
        }
    }
}

