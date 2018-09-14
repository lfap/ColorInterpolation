//
//  ViewController.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 13/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numberOfBars: Int = 4
    
    lazy var chartSize: CGSize = {
        return view.frame.size
    }()
    
    var spaceBetweenBars: CGFloat = 0.0 {
        didSet {
            let limitValue = chartSize.width / CGFloat(numberOfBars)
            if spaceBetweenBars > limitValue {
                spaceBetweenBars = limitValue
            }
        }
    }
    
    lazy var totalGapsScpace: CGFloat = {
        return spaceBetweenBars * CGFloat(numberOfBars + 1)
    }()
    
    lazy var availableWidth: CGFloat = {
        return chartSize.width - totalGapsScpace
    }()
    
    lazy var barWidth: CGFloat = {
        return availableWidth / CGFloat(numberOfBars)
    }()
    
    // MARK: Colors
    let initialColor: UIColor = UIColor.red
    let middleColor: UIColor = UIColor.green
    let finalColor: UIColor = UIColor.blue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spaceBetweenBars = 5
        
        createView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createView() {
        
        let barHeight: CGFloat = view.frame.height
        
        var xPosition: CGFloat = spaceBetweenBars
        let progress: CGFloat = 1 / (CGFloat(numberOfBars) / 3)
        
        for i in 0..<numberOfBars {
            
            let rect = CGRect(x: xPosition, y: 0, width: barWidth, height: barHeight)
            let bar = UIView(frame: rect)
            
            var color: UIColor
            
            let halfInterpolation: CGFloat = CGFloat(numberOfBars) / 2.0
            
            if CGFloat(i) < halfInterpolation {
//                let p = (progress * (1 / (CGFloat(numberOfBars) / 1.0))) * CGFloat(i)
                color = UIColor.interpolate(from: initialColor, to: middleColor, with: progress * CGFloat(i))
                
            } else {
//                let p = (progress * (1 / (CGFloat(numberOfBars) / 2.0))) * (CGFloat(i) - halfInterpolation)
                color = UIColor.interpolate(from: middleColor, to: finalColor, with: progress * (CGFloat(i) / 2.0))
                
            }
            
            bar.backgroundColor = color
            xPosition += barWidth + spaceBetweenBars
            view.addSubview(bar)
        }
    }
    
    
}

