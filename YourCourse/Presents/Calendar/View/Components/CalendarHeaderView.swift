//
//  CustomDatePickerHeader.swift
//  YourCourse
//
//  Created by 이민호 on 4/1/24.
//

import SwiftUI
import ComposableArchitecture

struct CalendarHeaderView: View {
    @Binding var showAddCourseView: Bool
    let store: StoreOf<CalendarFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 20) {
                Text(extractDate(date: viewStore.currentDate))
                    .font(.title3.bold())
                
                Spacer()
                
                Button {
                    showAddCourseView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

extension CalendarHeaderView {
    func extractDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarHeaderView(        
        showAddCourseView: .constant(false),
        store: Store(
            initialState: CalendarFeature.State(),
            reducer: { CalendarFeature()}
        )
    )                           
}
