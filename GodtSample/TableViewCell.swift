//
//  TableViewCell.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 23.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import UIKit

protocol TableViewCell: class {
    static var identifier: String { get }
    static var estimatedHeight: CGFloat { get }
    static func registerForTableView(tableView: UITableView)
    func clear()
}
