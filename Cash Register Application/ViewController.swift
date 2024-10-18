//
//  ViewController.swift
//  Cash Register Application
//
//  Created by Gurpreet Singh on 2024-10-17.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...9 {
            if let button = self.view.viewWithTag(i) as? UIButton {
                button.setTitle("\(i)", for: .normal)
            }}
        
    }
 
    var Quantity = 0
    var selectedItem = 0
    var price : Double = 0
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    @IBAction func buy(_ sender: Any) {
        
        guard let product = selectedProduct else {
                print("No product selected.")
                return
            }

            if Quantity > product.stock {
                // Show alert if quantity exceeds stock
                let alert = UIAlertController(title: "Insufficient Stock",
                                              message: "Only \(product.stock) \(product.name)s are available in stock.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }

            if Quantity > 0 {
                // Update stock
                products[selectedItem].stock -= Quantity
                print("Bought \(Quantity) of \(product.name). New stock: \(products[selectedItem].stock)")

                // Create a Product instance for the purchase
                let purchasedProduct = Product(name: product.name, price: product.price, stock: Quantity)
                purchasedProducts.append(purchasedProduct)  // Append to global array

                // Print to verify the product is added
                print("Purchased products array: \(purchasedProducts)")
                
                // Confirmation alert
                let alert = UIAlertController(title: "Purchase Successful",
                                              message: "You have bought \(Quantity) of \(product.name). Remaining stock: \(products[selectedItem].stock).",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                // Reset selections after purchase
                resetSelection()
            } else {
                print("Quantity must be greater than zero to complete the purchase.")
                // Show an alert if the quantity is zero
                let alert = UIAlertController(title: "Invalid Quantity",
                                              message: "Please select a quantity greater than zero.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }
    @IBOutlet weak var productList: UITableView!
    
    
    var products: [Product] = [
        Product(name: "Hat", price: 10, stock: 5),
        Product(name: "Shirt", price: 20, stock: 10),
        Product(name: "Shoes", price: 50, stock: 8),
        Product(name: "Pants", price: 30, stock: 12),
        Product(name: "Jacket", price: 75, stock: 4),
        Product(name: "Belt", price: 15, stock: 15),
        Product(name: "Socks", price: 5, stock: 25),
        Product(name: "Scarf", price: 20, stock: 10),
        Product(name: "Gloves", price: 12, stock: 6),
        Product(name: "Backpack", price: 40, stock: 7),
        Product(name: "T-shirt", price: 15, stock: 20),
        Product(name: "Sneakers", price: 60, stock: 9),
    ]
    var selectedProduct: Product?
    var selectedQuantity: Int = 0
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if let digitText = sender.titleLabel?.text, let digit = Int(digitText) {
            
            print("Digit pressed: \(digit)")
            
            
            if Quantity == 0 {
                Quantity = digit
            } else {
                
                Quantity = Quantity * 10 + digit
            }
            
            
            print("Updated Quantity: \(Quantity)")
            
            
            quantity.text = "\(Quantity)"
            
            
            updateTotal()
        } else {
            print("Error: Unable to retrieve the button's title or convert it to an integer.")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
            let product = products[indexPath.row]
            
           
            cell.textLabel?.text = product.name
            
           
            cell.detailTextLabel?.text = "Price: \(product.price)$, Stock: \(product.stock)"
            
            return cell
    }
    
    // Handle product selection
    //       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //           selectedProduct = products[indexPath.row]
    //           type.text = selectedProduct?.name ?? ""
    //           updateTotal()
    //           tableView.deselectRow(at: indexPath, animated: true)
    //       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle product selection
        let product = products[indexPath.row]
        selectedProduct = product
        Quantity = 0
        price = product.price
        selectedItem = indexPath.row
        
        type.text = product.name
        quantity.text = "0"
        total.text = "0$"
        updateTotal()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    func updateTotal() {
        guard let product = selectedProduct else { return }
        
        
        let totalPrice = Double(Quantity) * product.price
        
        
        print("Quantity: \(Quantity), Product Price: \(product.price), Total: \(totalPrice)")
        
        
        total.text = "\(String(format: "%.2f", totalPrice))$"
    }
    @IBAction func clear(_ sender: UIButton) {
        Quantity = 0
        
        
        type.text = "Select a product"
        quantity.text = "0"
        total.text = "0$"
        
        
        if let indexPath = productList.indexPathForSelectedRow {
            productList.deselectRow(at: indexPath, animated: true)
        }
    }
    func resetSelection() {
        selectedProduct = nil
            Quantity = 0
            type.text = "Select a product"
            quantity.text = "0"
            total.text = "0$"

            
            productList.reloadData()
        
    }
    
}
