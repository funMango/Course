//
//  CourseListView.swift
//  YourCourse
//
//  Created by 이민호 on 4/3/24.
//

import SwiftUI
import ComposableArchitecture

struct CourseListView: View {
    let store: StoreOf<CalendarFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                Section {
                    ForEach(getFilteredCourses(date: viewStore.currentDate, courses: viewStore.courses), id: \.self) { course in
                        NavigationLink {
                            CourseDetailView(store: Store(
                                initialState: CourseDetailFeature.State(course: course),
                                reducer: { CourseDetailFeature() }
                            ))
                        } label: {
                            CourseCellView(course: course)
                        }
                        .background(
                            Rectangle()
                                .frame(width: 6)
                                .foregroundColor(Color(hex: course.color.rawValue))
                                .cornerRadius(3.5),
                            alignment: .leading
                        )
                    }
                }
            }            
            .listStyle(.inset)
        }
    }
}

extension CourseListView {
    func getFilteredCourses(date: Date, courses: [Course]) -> [Course] {
        return courses.filter { course in
            let courseDates = course.getDays()
            
            return courseDates.contains(where: { courseDate in
                Calendar.current.isDate(courseDate, inSameDayAs: date)
            })
        }
    }
}

#Preview {
    CourseListView(
        store: Store(
            initialState: CalendarFeature.State(),
            reducer: { CalendarFeature()}
        ))
}
