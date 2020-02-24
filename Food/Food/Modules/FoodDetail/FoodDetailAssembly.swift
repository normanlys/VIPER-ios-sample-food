//
//  FoodDetailAssembly.swift
//  Food
//
//  Created by norman.lim on 24/2/2020.
//  Copyright © 2020 norman.lim. All rights reserved.
//

import Foundation
import UIKit
import Swinject

final class FoodDetailAssembly {
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func module(food: Food) -> UIViewController {
        let interactor = resolver.resolve(FoodDetailInteractorProtocol.self)!
        let router = resolver.resolve(FoodDetailRouterProtocol.self)!
        let view = resolver.resolve(FoodDetailViewProtocol.self)!
        
        let vc = FoodDetailViewController(food: food, interactor: interactor, router: router, view: view)
        router.sourceViewController = vc
        view.presentor = vc
        
        return vc
    }
}

final class FoodDetailDIAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FoodDetailAssembly.self) { FoodDetailAssembly(resolver: $0) }
        container.autoregister(FoodDetailInteractorProtocol.self, initializer: FoodDetailInteractor.init)
        container.autoregister(FoodDetailRouterProtocol.self, initializer: FoodDetailRouter.init)
        container.autoregister(FoodDetailViewProtocol.self, initializer: FoodDetailView.init)
    }
}
