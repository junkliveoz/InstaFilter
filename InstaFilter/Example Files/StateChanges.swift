//
//  StateChanges.swift
//  InstaFilter
//
//  Created by Adam Sayer on 12/8/2024.
//

import SwiftUI

struct StateChanges: View {
    
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { oldValue, newValue in
                    print("New blur value: \(blurAmount)")
                    
                }
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

#Preview {
    StateChanges()
}
