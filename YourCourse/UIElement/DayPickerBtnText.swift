//
//  DayPickerBtnText.swift
//  YourCourse
//
//  Created by 이민호 on 4/17/24.
//

import SwiftUI

struct DayPickerBtnText: View {
    @Binding var showCalendar: Bool
    let title: String
    var body: some View {
        Text(title)
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .foregroundColor(showCalendar ? .red : .black)
            .background(Color(hex: "#eeeeee"))
            .cornerRadius(8)
    }
}
