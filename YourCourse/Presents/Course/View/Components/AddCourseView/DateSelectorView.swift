//
//  DateSelectorView.swift
//  YourCourse
//
//  Created by 이민호 on 3/26/24.
//

import SwiftUI
import ComposableArchitecture

enum SelectDateType {
    case start
    case end
}

struct DateSelectorView: View {
    @Binding var showCalendar: Bool
    let type: SelectDateType
    let store: StoreOf<CourseAddFeature>
    
    private var animation: Animation {
        .easeInOut(duration: 0.1)
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Text(type == .start ? "시작" : "종료")
                    .foregroundColor(.black)
                
                Spacer()
                
                Button {
                    withAnimation(animation) {
                        showCalendar.toggle()
                    }
                } label: {
                    DayPickerBtnText(
                        showCalendar: $showCalendar,
                        title: type == .start ?
                        "\(viewStore.course.startDate.formatDateToString())" :
                        "\(viewStore.course.endDate.formatDateToString())"
                    )
                }
            }
            
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
                        initialState: CourseAddFeature.State(),
                        reducer: { CourseAddFeature() }
                     ))
}
