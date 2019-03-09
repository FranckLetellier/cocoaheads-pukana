//
//  Assets.swift
//  Pukana
//
//  Created by Franck Letellier on 08/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import UIKit

enum Assets {
    enum Color: String {
        case action
        var color: UIColor { return UIColor(named: self.rawValue)! }
    }
}
