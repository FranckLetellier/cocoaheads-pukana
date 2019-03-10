//
//  FaceInfoServiceAR.swift
//  Pukana
//
//  Created by Franck Letellier on 10/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import ARKit

class FaceInfoServiceAR: NSObject {
    private var leftEye = 0.0
    private var rightEye = 0.0
    private var tongue = 0.0
}

extension FaceInfoServiceAR: FaceInfoService {
    func fetchLeftEyeValue() -> Double {
        return leftEye
    }
    
    func fetchRightEyeValue() -> Double {
        return rightEye
    }
    
    func fetchTongueValue() -> Double {
        return tongue
    }
}

extension FaceInfoServiceAR: ARSKViewDelegate {
    public func view(_ view: ARSKView, didUpdate node: SKNode, for anchor: ARAnchor) {
        guard
            let faceAnchor = anchor as? ARFaceAnchor,
            let tongueValue = faceAnchor.blendShapes[.tongueOut],
            let eyeRightValue = faceAnchor.blendShapes[.eyeWideRight],
            let eyeLeftValue = faceAnchor.blendShapes[.eyeWideLeft] else { return }
        
        self.tongue = tongueValue.doubleValue
        self.rightEye = eyeRightValue.doubleValue
        self.leftEye = eyeLeftValue.doubleValue
    }
}
