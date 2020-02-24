//
//  FoodListPresentor.swift
//  Food
//
//  Created by norman.lim on 24/2/2020.
//  Copyright © 2020 norman.lim. All rights reserved.
//

import Foundation
import UIKit

protocol FoodListPresentorProtocol: AnyObject {
    func showFoodDetail(id: String)
}

class FoodListController: UIViewController {
    
    private let interactor: FoodListInteractorProtocol
    private let moduleView: FoodListViewProtocol
    private let router: FoodListRouterProtocol
    
    var foods: [Food] = []
    
    init(interactor: FoodListInteractorProtocol, moduleView: FoodListViewProtocol, router: FoodListRouterProtocol) {
        self.interactor = interactor
        self.moduleView = moduleView
        self.router = router
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
        moduleView.startLoading()
        interactor.getFoods { (result) in
            self.moduleView.stopLoading()
            switch result {
            case .success(let foods):
                self.foods = foods
                let vm = FoodListViewModel(foods: foods)
                self.moduleView.presentModel(vm)
            case .failure(let error):
                self.router.showFailureAlert(error: error)
            }
        }
    }
}

extension FoodListController: FoodListPresentorProtocol {
    func showFoodDetail(id: String) {
        guard let food = foods.first(where: { $0.id == id }) else { return }
        router.showFoodDetail(food)
    }    
}
