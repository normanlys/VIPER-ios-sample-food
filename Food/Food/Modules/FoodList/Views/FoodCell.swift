//
//  FoodCell.swift
//  Food
//
//  Created by norman.lim on 24/2/2020.
//  Copyright © 2020 norman.lim. All rights reserved.
//

import Foundation
import UIKit

final class FoodCell: UITableViewCell {
    func present(model: FoodListItem) {
        textLabel?.text = model.id
    }
}
