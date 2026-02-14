//
//  Product.swift
//  StripeDemo
//
//  Created by Sameer Nadaf on 14/02/26.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: Double
    let imageName: String
}

extension Product {
    static let sampleData: [Product] = [
        Product(name: "T-Shirt", description: "A comfortable cotton t-shirt.", price: 19.99, imageName: "tshirt"),
        Product(name: "Jeans", description: "Classic blue jeans.", price: 49.99, imageName: "figure.stand"),
        Product(name: "Sneakers", description: "Running shoes.", price: 79.99, imageName: "shoe")
    ]
}
