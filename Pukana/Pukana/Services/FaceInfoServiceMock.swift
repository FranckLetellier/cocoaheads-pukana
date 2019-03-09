//
//  FaceInfoServiceMock.swift
//  Pukana
//
//  Created by Franck Letellier on 09/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import Foundation

class FaceInfoServiceMock: FaceInfoService {
    
    private func randomValue() -> Double {
        return Double.random(in: 0...1)
    }
    
    func fetchLeftEyeValue() -> Double {
        return randomValue()
    }
    
    func fetchRightEyeValue() -> Double {
        return randomValue()
    }
    
    func fetchTongueValue() -> Double {
        return randomValue()
    }
}
