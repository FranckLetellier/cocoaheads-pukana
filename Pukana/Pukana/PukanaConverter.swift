//
//  PukanaConverter.swift
//  Pukana
//
//  Created by Franck Letellier on 09/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import Foundation

class PukanaConverter {
    
    private static let leftEyeWeight = 1.0
    private static let rightEyeWeight = 1.0
    private static let tongueWeight = 1.0
    
    static func getScore(fromLeftEye leftEye: Double, rightEye: Double, tongue:Double) -> Int {
        print("LeftEye: \(leftEye) - RightEye: \(rightEye) - Tongue: \(tongue)")
        let total: Double = leftEye * leftEyeWeight + rightEye * rightEyeWeight + tongue * tongueWeight
        let totalAverage = total / leftEyeWeight + rightEyeWeight + tongueWeight
        let score = Int(totalAverage * 1000.0)
        print("Score: \(score)")
        return score
    }
}
