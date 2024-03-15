//
//  LargeTitleText.swift
//  YourCourse
//
//  Created by 이민호 on 3/11/24.
//

import SwiftUI

struct LargeTitleText: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 40, weight: .bold))
            
            Spacer()
        }
    }
}

//#Preview {
//    LargeTitleText()
//}
