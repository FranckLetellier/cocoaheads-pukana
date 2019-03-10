//
//  ViewController.swift
//  Pukana
//
//  Created by Franck Letellier on 08/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    // Gamestate
    enum GameState {
        case setup
        case idle
        case countdown
        case result
    }
    private var gameState = GameState.setup
    
    // Services
    lazy var faceInfoService: FaceInfoService = {return FaceInfoServiceMock()}()
    
    // Coundown
    private var timer: Timer?
    private var count = 3
    
    // UI
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var idleUIView: UIView!
    @IBOutlet weak var resultUIView: UIView!
    
    private var finishPhotoView: UIView?
    @IBOutlet weak var resultScoreLabel: UILabel!
    
    @IBOutlet weak var arView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAR()
        launchGame()
    }
    
    private func setupAR(){
        
        let scene = SKScene(size: arView.bounds.size)
        scene.scaleMode = .resizeFill
        arView.presentScene(scene)
        
        let configuration = ARFaceTrackingConfiguration()
        arView.session.run(configuration)
    }
    
    private func launchGame(){
        let faceInfoService = FaceInfoServiceAR()
        arView.delegate = faceInfoService
        self.faceInfoService = faceInfoService
        
        goTo(state: .idle)
    }
    
    private func resetUI(){
        finishPhotoView?.removeFromSuperview()
        idleUIView.isHidden = true
        resultUIView.isHidden = true
        countdownLabel.isHidden = true
    }
    
    private func goTo(state: GameState) {
        resetUI()
        switch state {
        case .idle:
            idleUIView.isHidden = false
            
        case .countdown:
            launchTimer()
            countdownLabel.isHidden = false
            
        case .result:
            resultUIView.isHidden = false
            saveScore()
            flashView()
            presentResultImage()
            
        case .setup: break
        }
        gameState = state
    }
    
    private func launchTimer() {
        // Early exit if already running
        guard
            timer == nil ||
                timer!.isValid == false else {
                    return
        }
        // Reset count
        count = 4
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [weak self] timer in
            guard let count = self?.count, count > 1 else {
                timer.invalidate()
                self?.goTo(state: .result)
                return
            }
            self?.count -= 1
            self?.countdownLabel.text = String(self?.count ?? 0)
        }
        timer?.fire()
    }
    
    private func saveScore(){
        let resultScore = PukanaConverter.getScore(fromLeftEye: faceInfoService.fetchLeftEyeValue(),
                                                   rightEye: faceInfoService.fetchRightEyeValue(),
                                                   tongue: faceInfoService.fetchTongueValue())

        resultScoreLabel.text = Score(value:resultScore).description
    }
    
    private func presentResultImage() {
        if let snapshot = arView.snapshotView(afterScreenUpdates: true){
            resultUIView.insertSubview(snapshot, at: 0)
            finishPhotoView = snapshot
        }
    }
    
    private func flashView() {
        let flashView = UIView(frame: view.bounds)
        flashView.backgroundColor = .white
        view.addSubview(flashView)
        UIView.animate(withDuration: 0.5, animations: {
            flashView.alpha = 0
        }) { (completed) in
            if completed {
                flashView.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func goAction(_ sender: UIButton) {
        goTo(state: .countdown)
    }
    
    @IBAction func goHome(_ sender: UIButton) {
        goTo(state: .idle)
    }
}

extension ViewController: ARSKViewDelegate {
    public func view(_ view: ARSKView, didUpdate node: SKNode, for anchor: ARAnchor) {
        
    }
}
