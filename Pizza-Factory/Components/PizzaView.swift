//
//  PizzaView.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import UIKit

class PizzaView: UIView {

    var mPizza: PizzaModel?
    
    @IBOutlet var vRoot: UIView!
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initNib()
    }

    private func initNib() {
        self.backgroundColor = .clear
        Bundle(for: PizzaView.self).loadNibNamed("PizzaView", owner: self, options: nil)
        self.addSubview(self.vRoot)
        self.vRoot.frame = bounds
        self.vRoot.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.initUI()
    }
    
    deinit {
        
    }
    
    var bEditExtended = false
    
    // MARK: - Core
    private func initUI() {
        self.vPizzaContainer.backgroundColor = .white
        self.lblPizzaName.textColor = .black
        self.lblPizzaName.text = ""
        
        // Edit
        self.extendEdit(false)
        // Size
    }
    
    // MARK: - Update UI
    func updateUI(_ mPizza: PizzaModel, chef mChef: ChefModel) {
        self.mPizza = mPizza
        self.mPizza?.mChef = mChef
        self.vPizzaContainer.backgroundColor = mPizza.mChef?.colorChef.withAlphaComponent(0.3)
        self.lblPizzaName.text = String(format: "Pizza_%04i", mPizza.iPizzaId)
        self.lblPizzaName.textColor = mPizza.mChef?.colorChef
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
