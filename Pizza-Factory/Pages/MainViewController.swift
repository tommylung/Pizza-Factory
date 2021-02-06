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
    var arrChefView = [ChefView]()
    let chefQueue = DispatchQueue(label: "ChefQueue",
                                    qos: .userInitiated,
                                    attributes: .concurrent,
                                    autoreleaseFrequency: .workItem,
                                    target: nil)
    
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
            
            vChef.vm.psSwitchStartChangeValue.subscribe(onNext: { [weak self] b in
                
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
        for i in 0...999 {
            self.arrPizza.append(PizzaModel(id: i))
        }
        self.updateSummary()
    }
    
    // MARK: - Update UI
    func updateSummary() {
        self.lblSummaryTitle.text = "Bindo Pizza Factory Summary (Total: \(arrPizza.count))"
        
        for (index, v) in self.arrChefView.enumerated() {
            switch index {
            case 0: self.lblSummaryChef0.text = "Pizza Chef 0: \(v.mChef.iRemainPizza)"
            case 1: self.lblSummaryChef1.text = "Pizza Chef 1: \(v.mChef.iRemainPizza)"
            case 2: self.lblSummaryChef2.text = "Pizza Chef 2: \(v.mChef.iRemainPizza)"
            case 3: self.lblSummaryChef3.text = "Pizza Chef 3: \(v.mChef.iRemainPizza)"
            case 4: self.lblSummaryChef4.text = "Pizza Chef 4: \(v.mChef.iRemainPizza)"
            case 5: self.lblSummaryChef5.text = "Pizza Chef 5: \(v.mChef.iRemainPizza)"
            case 6: self.lblSummaryChef6.text = "Pizza Chef 6: \(v.mChef.iRemainPizza)"
            default: break
            }
        }
    }
    
    // MARK: - Action
    @IBAction func btnAdd10PizzaClickEvent(_ sender: Any) {
        let iTotal = self.arrPizza.count
        for i in 1...10 {
            self.arrPizza.append(PizzaModel(id: (iTotal + i)))
        }
        self.updateSummary()
    }
    
    @IBAction func btnAdd100PizzaClickEvent(_ sender: Any) {
        let iTotal = self.arrPizza.count
        for i in 1...100 {
            self.arrPizza.append(PizzaModel(id: (iTotal + i)))
        }
        self.updateSummary()
    }
    
    @IBAction func switchAllChangeValue(_ sender: UISwitch) {
        self.changeAllSwitch(sender.isOn)
    }
    
    func changeAllSwitch(_ bAll: Bool) {
        self.arrChefView.forEach {
            $0.switchStart.isOn = bAll
        }
    }
    
    func createPizza(view vPizza: PizzaView) {
        
    }
}

