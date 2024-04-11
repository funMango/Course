//
//  MemoTextEditor.swift
//  YourCourse
//
//  Created by 이민호 on 4/5/24.
//

import SwiftUI

struct MemoTextEditor: View {
    @FocusState var isMemoFocused: Bool
    @Binding var content: String
    var placeholder: String
    let isFocused: FocusState<Bool>.Binding
    
    
    var body: some View {
        TextEditor(text: $content)
            .foregroundColor(content == placeholder ? Color(hex: "#D3D3D5") : .primary)
            .cornerRadius(15)
            .frame(minHeight: 200, maxHeight: 300)
            .focused(isFocused)
            .focused($isMemoFocused)
            .autocorrectionDisabled()
            .onTapGesture {
                if content == placeholder {
                    content = ""
                }
            }
            .onChange(of: isMemoFocused) {
                if !isMemoFocused && content.isEmpty {
                    content = placeholder
                }
            }
    }
}
