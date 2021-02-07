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
    
//    let t = DispatchSource.makeTimerSource()
    var t: RepeatingTimer?
    
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
        self.lblChefName.text = "Pizza Chef \(self.mChef.iChefId)"
        self.updateRemaining()
        self.lblSpeed.text = "Speed: \(self.mChef.tiSpeed) s/pizza"
        
        self.vChef.setBorder(color: .black, width: 1.0)
        self.vChefInformation.setBorder(color: .black, width: 1.0)
        self.svPizza.setBorder(color: .black, width: 1.0)
    }
    
    // MARK: - Update UI
    func updateUI() {
        
    }
    
    func updateRemaining() {
        self.lblRemaining.text = "Remaining: \(self.mChef.getPizzaRemain())"
    }
    
    func addPizza(_ mPizza: PizzaModel) {
        self.mChef.addNewPizza(mPizza)
        self.updateRemaining()
    }
    
    func makeNewPizza() {
        let newPizza = self.mChef.arrPizza.removeFirst()
        self.mChef.arrPizzaMade.append(newPizza)
        self.makePizza(newPizza)
    }
    
    func makePizza(_ mPizza: PizzaModel) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            guard let self = self else { return }
            let vPizza = PizzaView()
            self.skvPizza.addArrangedSubview(vPizza)
            vPizza.updateUI(mPizza, chef: self.mChef)
        }
    }
    
    // Turn on / off factory of each chef
    func switchFactory(isOn bOn: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            guard let self = self else { return }
            self.switchStart.isOn = bOn
            self.vm.psSwitchFactory.onNext((bOn))
        }
        if bOn {
            self.t = RepeatingTimer(timeInterval: self.mChef.tiSpeed)
            
            t?.eventHandler = {
                if self.mChef.arrPizza.count > 0 {
                    self.makeNewPizza()
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
                    guard let self = self else { return }
                    self.updateRemaining()
                }
            }
            t?.resume()
        } else {
            t?.suspend()
        }
        
    }
    
    // MARK: - Action
    @IBAction func switchStartChangeValue(_ sender: UISwitch) {
        // Toggle
        self.mChef.bStart = sender.isOn
        self.switchFactory(isOn: sender.isOn)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
