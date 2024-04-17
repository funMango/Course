//
//  ColorSectionView.swift
//  YourCourse
//
//  Created by 이민호 on 3/31/24.
//

import SwiftUI
import ComposableArchitecture



struct ColorSectionView: View {
    let store: StoreOf<CourseAddFeature>
    var colors: [CourseColor] = [.red, .blue, .yellow, .brown, .navy, .purple]
    @State private var selectOption = 0
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Section {                                                                                             
                Picker("색상", selection: viewStore.$course.color) {                                        
                    Text(CourseColor.red.getColorName()).tag(CourseColor.red)
                    Text(CourseColor.blue.getColorName()).tag(CourseColor.blue)
                    Text(CourseColor.yellow.getColorName()).tag(CourseColor.yellow)
                    Text(CourseColor.navy.getColorName()).tag(CourseColor.navy)
                    Text(CourseColor.purple.getColorName()).tag(CourseColor.purple)
                }
            }
        }
    }
}

#Preview {
    ColorSectionView(store: Store(
        initialState: CourseAddFeature.State(),
        reducer: { CourseAddFeature() }
    ))
}
