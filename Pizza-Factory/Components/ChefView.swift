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
    
    var t: RepeatingTimer?
    var arrPizzaView = [PizzaView]()
    
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
        
        let vPizza = PizzaView()
        self.skvPizza.addArrangedSubview(vPizza)
        self.arrPizzaView.append(vPizza)
        vPizza.updateUI(mPizza, chef: self.mChef)
    }
    
    func makeNewPizza() {
        if self.mChef.arrPizza.count > 0 {
            let newPizza = self.mChef.arrPizza.removeFirst()
            newPizza.status = true
            self.mChef.arrPizzaMade.append(newPizza)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
                guard let self = self else { return }
                self.arrPizzaView[self.mChef.arrPizzaMade.count - 1].madePizza()
            }
            
            self.vm.psMadeNewPizza.onNext(())
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
                guard let self = self else { return }
                self.switchStart.setOn(false, animated: true)
            }
            self.t?.suspend()
        }
    }
    
    // Turn on / off factory of each chef
    func switchFactory(isOn bOn: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            guard let self = self else { return }
            self.switchStart.setOn(bOn, animated: true)
            self.vm.psSwitchFactory.onNext((bOn))
        }
        if bOn {
            self.t = RepeatingTimer(timeInterval: self.mChef.tiSpeed)
            
            t?.eventHandler = {
                self.makeNewPizza()
                
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
        
        if self.mChef.arrPizza.count == 0 {
            self.switchStart.setOn(false, animated: true)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
