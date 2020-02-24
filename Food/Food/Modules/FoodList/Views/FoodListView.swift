//
//  FoodListView.swift
//  Food
//
//  Created by norman.lim on 24/2/2020.
//  Copyright © 2020 norman.lim. All rights reserved.
//

import Foundation
import UIKit
import Stevia

protocol FoodListViewProtocol: AnyView {
    var presentor: FoodListPresentorProtocol? { get set }
    func presentModel(_ model: FoodListViewModel)
    func startLoading()
    func stopLoading()
}

struct FoodListItem {
    let id: String
}

struct FoodListViewModel {
    let listItems: [FoodListItem]
    
    init(foods: [Food]) {
        listItems = foods.map { FoodListItem(id: $0.id) }
    }
}

private enum Constant {
    static let cellIdentifier = "cell"
}

final class FoodListView: UIView {
    weak var presentor: FoodListPresentorProtocol?
    
    private var viewModel: FoodListViewModel?
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        adjustSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func adjustSubviews() {
        sv(tableView, activityIndicator)
        activityIndicator.fillContainer()
        activityIndicator.hidesWhenStopped = true
        
        tableView.fillContainer()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodCell.self, forCellReuseIdentifier: Constant.cellIdentifier)
    }
    
}

extension FoodListView: FoodListViewProtocol {
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func presentModel(_ model: FoodListViewModel) {
        viewModel = model
        tableView.reloadData()
    }
}

extension FoodListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier) as? FoodCell,
            let listItem = viewModel?.listItems[indexPath.row] else {
                return FoodCell()
        }
        cell.present(model: listItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.listItems.count ?? 0
    }
}

extension FoodListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let item = viewModel?.listItems[indexPath.row] else { return }
        presentor?.showFoodDetail(id: item.id)
    }
}
