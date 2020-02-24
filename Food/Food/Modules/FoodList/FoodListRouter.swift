//
//  FoodListRouter.swift
//  Food
//
//  Created by norman.lim on 24/2/2020.
//  Copyright © 2020 norman.lim. All rights reserved.
//

import Foundation
import UIKit

protocol FoodListRouterProtocol: RouterProtocol {
    func showFoodDetail(_ food: Food)
    func showFailureAlert(error: Error)
}

final class FoodListRouter: Router, FoodListRouterProtocol {
    let foodDetailAssembly: FoodDetailAssembly
    
    init(assembly: FoodDetailAssembly) {
        self.foodDetailAssembly = assembly
        super.init()
    }
    
    func showFoodDetail(_ food: Food) {
        let vc = foodDetailAssembly.module(food: food)
        sourceViewController?.present(vc, animated: true)
    }
    
    func showFailureAlert(error: Error) {
        switch error {
        case FoodListInteractorError.unableToReadFile:
            let alert = UIAlertController(title: "Cannot Read File", message: nil, preferredStyle: .alert)
            alert.addAction(.init(title: "Close", style: .cancel, handler: nil))
            sourceViewController?.present(alert, animated: false)
        default:
            break
        }
    }
}
