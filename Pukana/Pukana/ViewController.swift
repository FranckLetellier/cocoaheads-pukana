//
//  ViewController.swift
//  Pukana
//
//  Created by Franck Letellier on 08/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import UIKit

protocol FaceInfoService {
    func fetchLeftEyeValue() -> Double
    func fetchRightEyeValue() -> Double
    func fetchTongueValue() -> Double
}

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



class ViewController: UIViewController {

    
    enum GameState {
        case idle
        case countdown
        case result
    }
    private var gameState = GameState.idle
    
    
    var timer: Timer?
    var count = 3
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var idleUIView: UIView!
    @IBOutlet weak var resultUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            let _ = PukanaConverter.getScore(fromLeftEye: Double.random(in: 0...1),
                                                  rightEye: Double.random(in: 0...1),
                                                  tongue: Double.random(in: 0...1))
           
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
        
    }
    
    
    // MARK: - Actions
    @IBAction func goAction(_ sender: UIButton) {
        goTo(state: .countdown)
    }
    
    @IBAction func goHome(_ sender: UIButton) {
        goTo(state: .idle)
    }
}

