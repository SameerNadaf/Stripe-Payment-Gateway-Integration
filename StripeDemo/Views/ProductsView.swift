//
//  ProductsView.swift
//  StripeDemo
//
//  Created by Sameer Nadaf on 14/02/26.
//

import SwiftUI

struct ProductsView: View {
    let products = Product.sampleData
    
    var body: some View {
        List(products) { product in
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
                
                Text(String(format: "$%.2f", product.price))
                    .font(.body)
            }
        }
        .navigationTitle("Products")
    }
}

#Preview {
    NavigationStack {
        ProductsView()
    }
}
