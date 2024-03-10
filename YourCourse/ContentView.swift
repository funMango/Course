//
//  ContentView.swift
//  YourCourse
//
//  Created by 이민호 on 3/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#if DEBUG
    #Preview {
        ContentView()
    }
#endif
