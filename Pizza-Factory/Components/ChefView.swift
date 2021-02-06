//
//  ChefView.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import RxSwift
import UIKit

class ChefView: UIView {

    var disposeBag = DisposeBag()
    var vm = ChefViewModel()
    var mChef = ChefModel()
    
    @IBOutlet var vRoot: UIView!
    // Chef Information
    @IBOutlet weak var vChef: UIView!
    @IBOutlet weak var imgvChef: UIImageView!
    @IBOutlet weak var switchStart: UISwitch!
    @IBOutlet weak var vChefInformation: UIView!
    @IBOutlet weak var lblChefName: UILabel!
    @IBOutlet weak var lblRemaining: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    
    // Pizza
    @IBOutlet weak var svPizza: UIScrollView!
    @IBOutlet weak var skvPizza: UIStackView!
     
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
        Bundle(for: ChefView.self).loadNibNamed("ChefView", owner: self, options: nil)
        self.addSubview(self.vRoot)
        self.vRoot.frame = bounds
        self.vRoot.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.initUI()
    }
    
    deinit {
        
    }
    
    // MARK: - Core
    private func initUI() {
        self.imgvChef.setImageColor(color: self.mChef.colorChef)
        self.lblChefName.text = String(format: "Pizza Chef %i", self.mChef.iChefId)
        self.lblRemaining.text = String(format: "Remaining: %i", self.mChef.iRemainPizza)
        self.lblSpeed.text = String(format: "Speed: %i s/pizza", self.mChef.iSpeed)
        
        self.vChef.setBorder(color: .black, width: 1.0)
        self.vChefInformation.setBorder(color: .black, width: 1.0)
        self.svPizza.setBorder(color: .black, width: 1.0)
    }
    
    // MARK: - Update UI
    func updateUI() {
        
    }
    
    func addPizza(_ mPizza: PizzaModel) {
        
    }
    
    // MARK: - Action
    @IBAction func switchStartChangeValue(_ sender: UISwitch) {
        self.mChef.bStart = sender.isOn
        self.vm.psSwitchStartChangeValue.onNext((sender.isOn))
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
