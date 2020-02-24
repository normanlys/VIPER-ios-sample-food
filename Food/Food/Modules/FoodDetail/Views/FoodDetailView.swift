//
//  FoodDetailView.swift
//  Food
//
//  Created by norman.lim on 24/2/2020.
//  Copyright © 2020 norman.lim. All rights reserved.
//

import Foundation
import UIKit
import Stevia

protocol FoodDetailViewProtocol: AnyView {
    var presentor: FoodDetailPresentorProtocol? { get set }
    func presentModel(_ model: FoodDetailViewModel)
}

struct FoodDetailViewModel {
    let id: String
    
    init(food: Food) {
        id = food.id
    }
}

private struct Constants {
    static let margin: CGFloat = 8
}

final class FoodDetailView: UIView {
    private var viewModel: FoodDetailViewModel?
    
    private let label = UILabel()
    private let closeButton = UIButton(type: .close)
    
    weak var presentor: FoodDetailPresentorProtocol? {
        didSet {
            closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        adjustSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func adjustSubviews() {
        backgroundColor = .white
        label.numberOfLines = 0
        
        sv(label, closeButton)
        label.top(Constants.margin)
        label.left(Constants.margin)
        closeButton.top(Constants.margin)
        closeButton.right(Constants.margin)
    }
    
    @objc private func closeButtonPressed() {
        presentor?.dismiss()
    }
}

extension FoodDetailView: FoodDetailViewProtocol {
    func presentModel(_ model: FoodDetailViewModel) {
        viewModel = model
        label.text = viewModel?.id
    }
}
