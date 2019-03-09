//
//  ViewController.swift
//  Pukana
//
//  Created by Franck Letellier on 08/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Gamestate
    enum GameState {
        case idle
        case countdown
        case result
    }
    private var gameState = GameState.idle
    
    // Services
    let faceInfoService: FaceInfoService = FaceInfoServiceMock()
    
    // Coundown
    private var timer: Timer?
    private var count = 3
    
    // UI
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var idleUIView: UIView!
    @IBOutlet weak var resultUIView: UIView!
    
    @IBOutlet weak var resultScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goTo(state: .idle)
    }
    
    private func resetUI(){
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
        resultScoreLabel.text = "\(resultScore)"
    }
    
    
    // MARK: - Actions
    @IBAction func goAction(_ sender: UIButton) {
        goTo(state: .countdown)
    }
    
    @IBAction func goHome(_ sender: UIButton) {
        goTo(state: .idle)
    }
}

