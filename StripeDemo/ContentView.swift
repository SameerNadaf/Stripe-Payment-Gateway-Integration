//
//  ContentView.swift
//  StripeDemo
//
//  Created by Sameer Nadaf on 12/02/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Stripe Demo App")
                    .font(.largeTitle)
                
                NavigationLink("Go to Products", destination: ProductsView())
                    .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
