//
//  ChefViewModel.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import RxSwift

class ChefViewModel {
    let psSwitchFactory = PublishSubject<Bool>()
    let psMadeNewPizza = PublishSubject<Void>()
}
