//
//  FoodListInteractor.swift
//  Food
//
//  Created by norman.lim on 24/2/2020.
//  Copyright © 2020 norman.lim. All rights reserved.
//

import Foundation

enum FoodListInteractorError: Error {
    case unableToReadFile
}

protocol FoodListInteractorProtocol {
    func getFoods(completion: @escaping (Result<[Food], Error>) -> Void)
}

final class FoodListInteractor: FoodListInteractorProtocol {
    func getFoods(completion: @escaping (Result<[Food], Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard
                let path = Bundle.main.path(forResource: "Foods", ofType: "json"),
                let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
                let json = try? JSONDecoder().decode([Food].self, from: jsonData) else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        completion(.failure(FoodListInteractorError.unableToReadFile))
                    }
                    return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(.success(json))
            }
        }
    }
}
