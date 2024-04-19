//
//  DateSelectorView.swift
//  YourCourse
//
//  Created by 이민호 on 3/26/24.
//

import SwiftUI
import ComposableArchitecture

protocol DateSelectable {
    var course: Course { get set }
}

enum SelectDateType {
    case start
    case end
}

struct DateSelectorView: View {
    @Binding var showCalendar: Bool
    let type: SelectDateType
    let store: StoreOf<CourseFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in        
            DateSelectionButton(
                showCalendar: $showCalendar,
                type: type,
                title: type == .start ?
                    "\(viewStore.course.startDate.formatDateToString())" :
                    "\(viewStore.course.endDate.formatDateToString())"
            )
            
            
            if showCalendar {                
                DatePicker(
                    type == .start ? "시작" : "종료",
                    selection: type == .start ? viewStore.$course.startDate : viewStore.$course.endDate,
                    in: type == .start ?
                        Date.distantPast...Date.distantFuture :
                        viewStore.course.startDate...Date.distantFuture,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .frame(width: 320)
            }
        }
    }
}

#Preview {
    DateSelectorView(showCalendar: .constant(false),
                     type: .start,
                     store: Store(
                        initialState: CourseFeature.State(),
                        reducer: { CourseFeature() }
                     ))
}
