//
//  PCSectionSeparator.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 17/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit


class PCSectionSeparator: UIView {
    
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        createSectionSeparator()
        
        UIColor.darkGray.setStroke()
        path.stroke()
    }
    
    func createSectionSeparator() {
        path = UIBezierPath()
        
        path.lineWidth = 1.5
        
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: 7.0))
        path.addLine(to: CGPoint(x: frame.width - 0.75, y: 7.0))
        path.addLine(to: CGPoint(x: frame.width - 0.75, y: 0.0))
    }
}
