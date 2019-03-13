#Punaka Snipetty
Add an ARView :
```
    var arView: ARSKView!
```

Configurate The AR view:
```
    private func setupAR(){
        // Add the ARSpriteKitView
        arView = ARSKView(frame: view.bounds)
        view.insertSubview(arView, at: 0)

        // Scene needed to make the view running
        let scene = SKScene(size: arView.bounds.size)
        scene.scaleMode = .resizeFill
        arView.presentScene(scene)
        
        // Face tracking configuration
        let configuration = ARFaceTrackingConfiguration()
        arView.session.run(configuration)
    }

```

Launch the method setupAR() 
Add the ARView in storyboard
We are able to test the returned value
```
extension ViewController: ARSKViewDelegate {
    public func view(_ view: ARSKView, didUpdate node: SKNode, for anchor: ARAnchor) {
     
    }
}
```

Print the face values
```
	guard
		let faceAnchor = anchor as? ARFaceAnchor, 
		let eyeRightValue = faceAnchor.blendShapes[.eyeWideRight] else { return }
	print(eyeRightValue)
```

Add a view to present the final image
```
    private var finishPhotoView: UIView?
```

Present a image of the final score 
```
    private func presentResultImage() {
        if let snapshot = arView.snapshotView(afterScreenUpdates: true){
            resultUIView.insertSubview(snapshot, at: 0)
            finishPhotoView = snapshot
        }
    }
```

Create the FaceInfoServiceAR file
```
import ARKit

class FaceInfoServiceAR: NSObject {
    private var leftEye = 0.0
    private var rightEye = 0.0
    private var tongue = 0.0
}
```

Extend to conform to protocol
```
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
```

Make as a ARViewDelegate
```
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
```

Add the new service to the game
```
        let faceInfoService = FaceInfoServiceAR()
        arView.delegate = faceInfoService
        self.faceInfoService = faceInfoService
```