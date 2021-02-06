//
//  PizzaModel.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import Foundation

enum PizzaSize {
    case small, medium, large
}

enum PizzaTopping {
    case roastBeef, bellPapper, mushroom, onion, tomato, marinia, other
}

class PizzaModel: NSObject {
    var iPizzaId: Int = 0
    var pizzaSize: PizzaSize = .small
    var pizzaTopping = [PizzaTopping]()
    
    // true: done; false: Ready for making
    var status: Bool = false
    
    init(id iPizzaId: Int) {
        super.init()
        self.iPizzaId = iPizzaId
    }
}
