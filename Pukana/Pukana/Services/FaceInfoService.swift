//
//  FaceInfoService.swift
//  Pukana
//
//  Created by Franck Letellier on 09/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import Foundation

protocol FaceInfoService {
    func fetchLeftEyeValue() -> Double
    func fetchRightEyeValue() -> Double
    func fetchTongueValue() -> Double
}
