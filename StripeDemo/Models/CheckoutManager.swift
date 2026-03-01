//
//  CheckoutManager.swift
//  StripeDemo
//
//  Created by Sameer Nadaf on 01/03/26.
//

import Foundation
import StripePaymentSheet
import Combine

class CheckoutManager: ObservableObject {
    @Published var paymentSheet: PaymentSheet?
    @Published var checkoutError: String?
    @Published var isPreparing = false
    
    // Since iOS Simulator routes localhost correctly, this will hit your Node server
    let backendUrl = URL(string: "http://127.0.0.1:4242/create-payment-intent")!
    
    func prepareCheckout(for productPrice: Double) {
        self.isPreparing = true
        self.checkoutError = nil
        self.paymentSheet = nil
        
        let amountInCents = Int(productPrice * 100)
        
        var request = URLRequest(url: backendUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "amount": amountInCents,
            "currency": "usd"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isPreparing = false
                
                if let error = error {
                    self?.checkoutError = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let clientSecret = json["clientSecret"] as? String else {
                    self?.checkoutError = "Failed to parse client secret from backend"
                    return
                }
                
                // Configure PaymentSheet
                var configuration = PaymentSheet.Configuration()
                configuration.merchantDisplayName = "Stripe Demo Store, Inc."
                configuration.allowsDelayedPaymentMethods = true
                
                // Initialize PaymentSheet with the client secret and configuration
                self?.paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: configuration)
            }
        }.resume()
    }
}
