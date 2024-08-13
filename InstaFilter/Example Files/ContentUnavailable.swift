//
//  ContentUnavailable.swift
//  InstaFilter
//
//  Created by Adam Sayer on 13/8/2024.
//

import SwiftUI

struct ContentUnavailableDemo: View {
    var body: some View {
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: { Text("You don't have any saved snippets yet")
        } actions: {
            Button("Create snippet") {
                
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentUnavailableDemo()
}
