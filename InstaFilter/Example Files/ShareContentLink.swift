//
//  ShareContentLink.swift
//  InstaFilter
//
//  Created by Adam Sayer on 13/8/2024.
//

import SwiftUI

struct ShareContentLink: View {
    var body: some View {
        VStack {
            let example = Image(.example)
            
            Spacer()
            
            ShareLink(item: example, preview: SharePreview("Sydney Harbour", image: example)) {
                Label("Click to share", systemImage: "sailboat")
            }
            
            Spacer()
            
            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
                Label("Spread the word about Swift", systemImage: "swift")
            }
            
            Spacer()
            
            ShareLink(item: URL(string: "https://search.brave.com")!, subject: Text("Private Search Engine"), message: Text("Best search engine I have managed to find"))
            
            Spacer()
        }
    }
}

#Preview {
    ShareContentLink()
}
