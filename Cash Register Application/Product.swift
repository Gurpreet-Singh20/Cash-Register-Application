//
//  Product.swift
//  Cash Register Application
//
//  Created by Gurpreet Singh on 2024-10-17.
//

import Foundation


struct Product {
    let name: String
    let price: Double
    var stock: Int
    
    init(name: String, price: Double, stock: Int) {
            self.name = name
            self.price = price
            self.stock = stock
        }
}
