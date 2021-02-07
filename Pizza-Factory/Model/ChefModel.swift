//
//  ChefModel.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import UIKit

class ChefModel: NSObject {
    var iChefId: Int = 0 {
        didSet {
            // Set pizza speed
            self.tiSpeed = TimeInterval(self.iChefId + 1)
        }
    }
    var strChefName: String?
    var colorChef: UIColor = .black
    var bStart: Bool = false
    var tiSpeed: TimeInterval = 0
    var iPizzaTotal = 0
    
    var arrPizza = [PizzaModel]()
    var arrPizzaMade = [PizzaModel]()
    
    override init() {
        super.init()
        
        // Random color for each chef
        self.colorChef = UIColor.random
    }
    
    func addNewPizza(_ mPizza: PizzaModel) {
        self.arrPizza.append(mPizza)
        self.iPizzaTotal += 1
    }
    
    func getPizzaRemain() -> Int {
        return self.iPizzaTotal - self.arrPizzaMade.count
    }
}
