//
//  StripeDemoApp.swift
//  StripeDemo
//
//  Created by Sameer Nadaf on 12/02/26.
//

import SwiftUI
import StripePaymentSheet

@main
struct StripeDemoApp: App {
    init() {
        // Replace with your actual Stripe Publishable Key
        StripeAPI.defaultPublishableKey = "pk_test_51T64AZCatVDdRsnlcgI0hxozIQVCxhEOzq0EFWdRPMGhBdKev0uXMECr8jJIZPgmzG9qgwdGHuK4rJbQhFhVzgXU00Gzgt9dtG"
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
