//
//  ContentView.swift
//  WorkDaezWatchCompanion Watch App
//
//  Created by Daniel Agbemava on 21/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                
                Text("Did you work today?")
                Button("Yes") {
                    
                }
                .background(.green.opacity(0.5))
                .clipShape(.capsule)
                
                Button("No") {
                    
                }
                .background(.red.opacity(0.5))
                .clipShape(.capsule)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
