//
//  Score.swift
//  Pukana
//
//  Created by Franck Letellier on 10/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import Foundation

struct Score {
    let value: Int
    var description: String {
        switch value {
        case 0...300: return "\(value) ... Not Impressed"
        case 301...800: return "\(value). Nice"
        case 801...10000: return "\(value)!! Awesome !"
        default: return ""
        }
    }
}
