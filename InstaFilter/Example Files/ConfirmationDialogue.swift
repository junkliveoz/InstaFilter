//
//  ConfirmationDialogue.swift
//  InstaFilter
//
//  Created by Adam Sayer on 12/8/2024.
//

import SwiftUI

struct ConfirmationDialogue: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white

    var body: some View {
        Button("Hello, world!") {
            showingConfirmation.toggle()
        }
        .frame(width:300, height: 300)
        .background(backgroundColor)
        .clipShape(.circle)
        .confirmationDialog("Change Backgroun", isPresented: $showingConfirmation) {
            Button("Red") { backgroundColor = .red}
            Button("Green") { backgroundColor = .green}
            Button("Blue") { backgroundColor = .blue}
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Select a new color")
        }
    }
}

#Preview {
    ConfirmationDialogue()
}
