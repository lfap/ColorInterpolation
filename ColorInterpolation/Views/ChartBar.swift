//
//  ChartBar.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 14/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class ChartBar: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundBar: UIView!
    @IBOutlet weak var foregroundBar: UIView!
    
    @IBOutlet weak var equalsHeightConstraints: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ChartBar", owner: self, options: nil)
        containerView.backgroundColor = UIColor.clear
        
        self.addSubview(containerView)
        self.containerView.frame = self.bounds
        self.containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let cornerRadius: CGFloat = min(frame.width, frame.height) / 2
        
        containerView.layer.cornerRadius = cornerRadius
        containerView.clipsToBounds = true
        
        foregroundBar.layer.cornerRadius = cornerRadius
        foregroundBar.clipsToBounds = true
    }
    
    func setColor(_ color: UIColor) {
        foregroundBar.backgroundColor = color
    }
    
    /// value between 0.0 and 1.0
    func setHeightPercentage(_ value: CGFloat) {
        
        let newConstraint = equalsHeightConstraints.setMultiplier(multiplier: value)
        removeConstraint(equalsHeightConstraints)

        addConstraint(newConstraint)
        equalsHeightConstraints = newConstraint
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
