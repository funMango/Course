//
//  CourseInfoView.swift
//  YourCourse
//
//  Created by 이민호 on 4/19/24.
//

import SwiftUI
import ComposableArchitecture

struct CourseInfoView: View {
    let store: StoreOf<CourseFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Section {
                VStack(alignment: .leading) {
                    Text("\(viewStore.course.title)")
                        .font(.title3.bold())
                    
                    if !viewStore.course.location.isEmpty {
                        Text("\(viewStore.course.location)")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("\(viewStore.course.getPeriod())")
                        .font(.footnote)
                    
                }
            }
        }
    }
}


