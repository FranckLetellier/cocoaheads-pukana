//
//  RoundButton.swift
//  Pukana
//
//  Created by Franck Letellier on 08/03/2019.
//  Copyright © 2019 Double Dot. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
    
    /// We use an int enum so that it can be seen as a designable
    enum Style: Int {
        case plain = 0
        case outline
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 10
    }
    
    var style: Style = .plain {
        didSet {
            apply(style)
        }
    }
    
    @IBInspectable var styleForInspector: Int = 0 {
        didSet {
            if let typedStyle = Style(rawValue: styleForInspector) {
                style = typedStyle
            }
        }
    }
    
    @IBInspectable var color: UIColor = Assets.Color.action.color {
        didSet {
            apply(style)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        apply(style)
    }
    
    private func apply(_ style: Style) {
        
        // common behavior
        layer.cornerRadius = 10
        //contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
       
        // custom behavior
        switch style {
        case .plain:
            layer.borderWidth = 0
            backgroundColor = color
            setTitleColor(.white, for: .normal)
        case .outline:
            layer.borderWidth = 1
            layer.borderColor = color.cgColor
            backgroundColor = UIColor.white
            setTitleColor(color, for: .normal)
        }
    }
}
