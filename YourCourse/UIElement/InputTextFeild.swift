//
//  InputTextFeild.swift
//  YourCourse
//
//  Created by 이민호 on 4/5/24.
//

import SwiftUI

struct InputTextFeild: View {
    @Binding var text: String
    let title: String
    let keyboardType: UIKeyboardType
    let isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        TextField(title ,text: $text)
            .keyboardType(keyboardType)
            .autocorrectionDisabled()
            .focused(isFocused)
    }
}
