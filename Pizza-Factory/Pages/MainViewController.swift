//
//  ViewController.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 5/2/2021.
//

import RxSwift
import UIKit

class MainViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    // Background
    @IBOutlet weak var imgvBackground: UIImageView!
    
    // Chef
    @IBOutlet weak var skvChef: UIStackView!
    
    // Summary
    @IBOutlet weak var vSummary: UIView!
    @IBOutlet weak var lblSummaryTitle: UILabel!
    @IBOutlet weak var lblSummaryChef0: UILabel!
    @IBOutlet weak var lblSummaryChef1: UILabel!
    @IBOutlet weak var lblSummaryChef2: UILabel!
    @IBOutlet weak var lblSummaryChef3: UILabel!
    @IBOutlet weak var lblSummaryChef4: UILabel!
    @IBOutlet weak var lblSummaryChef5: UILabel!
    @IBOutlet weak var lblSummaryChef6: UILabel!
    
    // Action
    @IBOutlet weak var vAction: UIView!
    @IBOutlet weak var btnAdd10Pizza: UIButton!
    @IBOutlet weak var btnAdd100Pizza: UIButton!
    @IBOutlet weak var switchAll: UISwitch!
    
    var arrPizza = [PizzaModel]()
    var arrPizzaNotAssign = [PizzaModel]()
    var arrChefView = [ChefView]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - Core
    private func initUI() {
        self.imgvBackground.image = UIImage.getGratusGradientImage(self.imgvBackground.bounds)
        
        // Chef
        for i in 0...6 {
            let vChef = ChefView()
            let mChef = vChef.mChef
            mChef.iChefId = i
            self.skvChef.addArrangedSubview(vChef)
            self.arrChefView.append(vChef)
            
            vChef.vm.psMadeNewPizza.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.updateSummary()
            }).disposed(by: self.disposeBag)
            
            vChef.vm.psSwitchFactory.subscribe(onNext: { [weak self] bSwitch in
                guard let self = self else { return }
                if bSwitch {
                    self.switchAll.setOn(true, animated: true)
                }
            }).disposed(by: self.disposeBag)
        }
        
        // Action
        self.vAction.setBorder(color: .black, width: 1.0)
        
        // Summary
        self.vSummary.setBorder(color: .black, width: 1.0)
        self.btnAdd10Pizza.setBorder(color: .blue)
        self.btnAdd100Pizza.setBorder(color: .blue)
        // Default turn off
        self.switchAll.isOn = false
        self.changeAllSwitch(false)
        
        // Default pizza
        for i in 0...9 {
            self.arrPizzaNotAssign.append(PizzaModel(id: i))
        }
        self.assignPizza()
    }
    
    // MARK: - Update UI
    func updateSummary() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            guard let self = self else { return }
            
            self.lblSummaryTitle.text = "Bindo Pizza Factory Summary (Total: \(self.arrPizza.count))"
            
            for (index, v) in self.arrChefView.enumerated() {
                switch index {
                case 0: self.lblSummaryChef0.text = "Pizza Chef 0: \(v.mChef.getPizzaRemain())"
                case 1: self.lblSummaryChef1.text = "Pizza Chef 1: \(v.mChef.getPizzaRemain())"
                case 2: self.lblSummaryChef2.text = "Pizza Chef 2: \(v.mChef.getPizzaRemain())"
                case 3: self.lblSummaryChef3.text = "Pizza Chef 3: \(v.mChef.getPizzaRemain())"
                case 4: self.lblSummaryChef4.text = "Pizza Chef 4: \(v.mChef.getPizzaRemain())"
                case 5: self.lblSummaryChef5.text = "Pizza Chef 5: \(v.mChef.getPizzaRemain())"
                case 6: self.lblSummaryChef6.text = "Pizza Chef 6: \(v.mChef.getPizzaRemain())"
                default: break
                }
            }
        }
    }
    
    // MARK: - Assign
    func assignPizza() {
        for (index, mPizza) in self.arrPizzaNotAssign.enumerated() {
            mPizza.mChef = self.arrChefView[(index % 7)].mChef
            self.arrChefView[(index % 7)].addPizza(mPizza)
            self.arrPizza.append(self.arrPizzaNotAssign.removeFirst())
        }
        self.updateSummary()
    }
    
    // MARK: - Action
    @IBAction func btnAdd10PizzaClickEvent(_ sender: Any) {
        let iTotal = self.arrPizza.count
        for (index, i) in (0...9).enumerated() {
            let mPizza = PizzaModel(id: (iTotal + i))
            self.arrPizzaNotAssign.append(mPizza)
            self.arrChefView[(index % 7)].addPizza(mPizza)
            self.arrPizza.append(self.arrPizzaNotAssign.removeFirst())
        }
        self.updateSummary()
    }
    
    @IBAction func btnAdd100PizzaClickEvent(_ sender: Any) {
        let iTotal = self.arrPizza.count
        for (index, i) in (0...99).enumerated() {
            let mPizza = PizzaModel(id: (iTotal + i))
            self.arrPizzaNotAssign.append(mPizza)
            
            
            let mAssignedPizza = self.arrPizzaNotAssign.removeFirst()
            self.arrChefView[(index % 7)].addPizza(mAssignedPizza)
            self.arrPizza.append(mAssignedPizza)
            
        }
        self.updateSummary()
    }
    
    @IBAction func switchAllChangeValue(_ sender: UISwitch) {
        self.changeAllSwitch(sender.isOn)
    }
    
    func changeAllSwitch(_ bAll: Bool) {
        self.arrChefView.forEach {
            $0.switchFactory(isOn: bAll)
        }
    }
}

