//
//  FoodDetailController.swift
//  Food
//
//  Created by norman.lim on 24/2/2020.
//  Copyright © 2020 norman.lim. All rights reserved.
//

import Foundation
import UIKit

protocol FoodDetailPresentorProtocol: AnyObject {
    func dismiss()
}

final class FoodDetailViewController: UIViewController {
    let interactor: FoodDetailInteractorProtocol
    let router: FoodDetailRouterProtocol
    let moduleView: FoodDetailViewProtocol
    
    let food: Food
    
    init(food: Food, interactor: FoodDetailInteractorProtocol, router: FoodDetailRouterProtocol, view: FoodDetailViewProtocol) {
        self.food = food
        self.interactor = interactor
        self.router = router
        self.moduleView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = moduleView.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = FoodDetailViewModel(food: food)
        moduleView.presentModel(model)
    }
}

extension FoodDetailViewController: FoodDetailPresentorProtocol {
    func dismiss() {
        router.dismiss()
    }
}
