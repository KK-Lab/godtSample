//
//  JSON+Additions.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 23.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    var cleanString: String? {
        return self.string?.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
    }
}