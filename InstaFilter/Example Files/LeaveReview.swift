//
//  LeaveReview.swift
//  InstaFilter
//
//  Created by Adam Sayer on 13/8/2024.
//

import StoreKit
import SwiftUI

struct LeaveReview: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Leave a review") {
            requestReview()
        }
    }
}

#Preview {
    LeaveReview()
}
