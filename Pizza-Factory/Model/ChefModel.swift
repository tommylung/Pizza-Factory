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
            self.iSpeed = self.iChefId + 1
        }
    }
    var strChefName: String?
    var colorChef: UIColor = .black
    var bStart: Bool = false
    var iRemainPizza: Int = 0
    var iSpeed: Int = 0
    
    var arrPizza = [PizzaModel]()
    
    override init() {
        super.init()
        
        // Random color for each chef
        self.colorChef = UIColor.random
    }
}
