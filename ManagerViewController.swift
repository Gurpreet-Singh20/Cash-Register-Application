//
//  ManagerViewController.swift
//  Cash Register Application
//
//  Created by Gurpreet Singh on 2024-10-17.
//

import UIKit

class ManagerViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
        }
    var purchasedProducts: [Product] = []
       
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showHistory" {
                if let historyVC = segue.destination as? HistoryTableViewController {
                   
                    historyVC.purchasedProducts = purchasedProducts
                    
                   
                    print("Passing purchased products: \(purchasedProducts)")
                }
            }
        }

//        @IBAction func historyButtonTapped(_ sender: UIButton) {
//            print("History button tapped")
//            // This action can be used if you are not using a storyboard segue directly
//            performSegue(withIdentifier: "showHistory", sender: self)
//            
//        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    
}
