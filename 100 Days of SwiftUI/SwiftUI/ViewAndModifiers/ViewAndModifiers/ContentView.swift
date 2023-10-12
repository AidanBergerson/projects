//
//  ContentView.swift
//  ViewAndModifiers
//
//  Created by Aidan Bergerson on 10/3/23.
//

import SwiftUI

struct PromTitle: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        Text(text)
            .font(.largeTitle)
            .foregroundStyle(.blue).bold()
    }
}


extension View {
    func titleStyle() -> some View {
        modifier(PromTitle(text: "Hello World"))
    }
//extension View {
//    func titleStyle() -> some View {
//        modifier(Title())
//    }
}

struct ContentView: View {
    var body: some View {
        Text("")
            .titleStyle()
    }
}

#Preview {
    ContentView()
}
