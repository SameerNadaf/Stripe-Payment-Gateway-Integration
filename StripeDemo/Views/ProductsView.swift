//
//  ProductsView.swift
//  StripeDemo
//
//  Created by Sameer Nadaf on 14/02/26.
//

import SwiftUI
import StripePaymentSheet

struct ProductRowView: View {
    let product: Product
    @StateObject private var checkoutManager = CheckoutManager()
    @State private var showPaymentSheet = false
    @State private var paymentResult: PaymentSheetResult?
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        HStack {
            Image(systemName: product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text(product.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(String(format: "$%.2f", product.price))
                    .font(.subheadline)
                    .bold()
                
                Button(action: {
                    checkoutManager.prepareCheckout(for: product.price)
                }) {
                    if checkoutManager.isPreparing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Buy")
                            .font(.subheadline)
                            .bold()
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .disabled(checkoutManager.isPreparing)
            }
        }
        .onChange(of: checkoutManager.paymentSheet != nil) { _, isReady in
            if isReady { showPaymentSheet = true }
        }
        .onChange(of: checkoutManager.checkoutError) { _, error in
            if let error = error {
                alertMessage = error
                showAlert = true
            }
        }
        .background(
            Group {
                if let paymentSheet = checkoutManager.paymentSheet {
                    Color.clear.paymentSheet(isPresented: $showPaymentSheet,
                                             paymentSheet: paymentSheet,
                                             onCompletion: { result in
                        switch result {
                        case .completed:
                            alertMessage = "Payment successful!"
                        case .canceled:
                            alertMessage = "Payment canceled."
                        case .failed(let error):
                            alertMessage = "Payment failed: \(error.localizedDescription)"
                        }
                        showAlert = true
                    })
                }
            }
        )
        .alert("Status", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
}

struct ProductsView: View {
    let products = Product.sampleData
    
    var body: some View {
        List(products) { product in
            ProductRowView(product: product)
        }
        .navigationTitle("Products")
    }
}

#Preview {
    NavigationStack {
        ProductsView()
    }
}
