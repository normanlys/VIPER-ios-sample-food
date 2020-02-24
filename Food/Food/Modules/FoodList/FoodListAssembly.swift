//
//  FoodListAssembly.swift
//  Food
//
//  Created by norman.lim on 24/2/2020.
//  Copyright © 2020 norman.lim. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

final class FoodListAssembly {
    
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func module() -> UIViewController {
        let view = resolver.resolve(FoodListViewProtocol.self)!
        let interactor = resolver.resolve(FoodListInteractorProtocol.self)!
        let router = resolver.resolve(FoodListRouterProtocol.self)!
        
        let controller = FoodListController(interactor: interactor, moduleView: view, router: router)
        router.sourceViewController = controller
        view.presentor = controller
        
        return controller
    }
}

final class FoodListDIAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FoodListAssembly.self) { FoodListAssembly(resolver: $0) }
        container.autoregister(FoodListViewProtocol.self, initializer: FoodListView.init)
        container.autoregister(FoodListInteractorProtocol.self, initializer: FoodListInteractor.init)
        container.autoregister(FoodListRouterProtocol.self, initializer: FoodListRouter.init(assembly:))
    }
}
