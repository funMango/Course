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
    let store: StoreOf<CourseFeature>
    
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
                    Text(type == .start ?
                         "\(viewStore.startDate.formatDateToString())" :
                            "\(viewStore.endDate.formatDateToString())"
                    )
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .foregroundColor(showCalendar ? .red : .black)
                    .background(Color(hex: "#eeeeee"))
                    .cornerRadius(8)
                }
            }
            
            if showCalendar {                
                DatePicker(
                    type == .start ? "시작" : "종료",
                    selection: viewStore.binding(
                        get: type == .start ? \.startDate : \.endDate,
                        send: type == .start ?
                        CourseFeature.Action.setStartDate :
                            CourseFeature.Action.setEndDate
                    ),
                    in: type == .start ?
                        Date.distantPast...Date.distantFuture :
                        viewStore.startDate...Date.distantFuture,
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
