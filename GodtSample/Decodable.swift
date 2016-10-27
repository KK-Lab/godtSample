//
//  Decodable.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 23.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Decodable {
    static func decode(json: JSON) -> Self?
}