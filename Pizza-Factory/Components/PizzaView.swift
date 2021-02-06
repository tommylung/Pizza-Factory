//
//  PizzaView.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import UIKit

class PizzaView: UIView {

    var mPizza: PizzaModel?
    
    // Pizza
    @IBOutlet weak var vPizzaContainer: UIView!
    @IBOutlet weak var lblPizzaName: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
     
    // Additional
    // Size
    @IBOutlet weak var vSize: UIView!
    @IBOutlet weak var btnSizeSmall: UIButton!
    @IBOutlet weak var btnSizeMedium: UIButton!
    @IBOutlet weak var btnSizeLarge: UIButton!
    // Topping
    @IBOutlet weak var vTopping: UIView!
    @IBOutlet weak var btnToppingRoast: UIButton!
    @IBOutlet weak var btnToppingBellPepper: UIButton!
    @IBOutlet weak var btnToppingMushroom: UIButton!
    @IBOutlet weak var btnToppingOnion: UIButton!
    @IBOutlet weak var btnToppingTomato: UIButton!
    @IBOutlet weak var btnToppingMarinara: UIButton!
    @IBOutlet weak var btnToppingOther: UIButton!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.initUI()
    }
    
    var bEditExtended = false
    
    // MARK: - Core
    private func initUI() {
        self.vPizzaContainer.backgroundColor = .white
        self.lblPizzaName.textColor = .black
        self.lblPizzaName.text = ""
        
        // Edit
        self.extendEdit(false)
    }
    
    // MARK: - Update UI
    func updateUI(_ mPizza: PizzaModel) {
        self.mPizza = mPizza
        self.lblPizzaName.text =
            String(format: "Pizza_%4i", mPizza.iPizzaId)
    }
    
    func extendEdit(_ bExtend: Bool) {
        self.bEditExtended = bExtend
        self.vSize.isHidden = !bExtend
        self.vTopping.isHidden = !bExtend
    }
    
    // MARK: - Action
    @IBAction func btnEditClickEvent(_ sender: Any) {
        self.extendEdit(!self.bEditExtended)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
