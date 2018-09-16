////
////  ViewController.swift
////  ColorInterpolation
////
////  Created by Luiz Felipe Albernaz Pio on 13/09/18.
////  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    
//    let numberOfBars: Int = 20
//    
//    lazy var chartSize: CGSize = {
//        return view.frame.size
//    }()
//    
//    var spaceBetweenBars: CGFloat = 0.0 {
//        didSet {
//            let limitValue = chartSize.width / CGFloat(numberOfBars)
//            if spaceBetweenBars > limitValue {
//                spaceBetweenBars = limitValue
//            }
//        }
//    }
//    
//    lazy var totalGapsScpace: CGFloat = {
//        return spaceBetweenBars * CGFloat(numberOfBars + 1)
//    }()
//    
//    lazy var availableWidth: CGFloat = {
//        return chartSize.width - totalGapsScpace
//    }()
//    
//    lazy var barWidth: CGFloat = {
//        return availableWidth / CGFloat(numberOfBars)
//    }()
//    
//    lazy var progress: CGFloat = {
//        if numberOfBars > 3 {
//            return 2 / CGFloat(numberOfBars)
//        } else {
//            return 3 / CGFloat(numberOfBars)
//        }
//    }()
//    
//    private var progressiveHeight: Bool = false
//    
//    private var initialBarHeight: CGFloat {
//        if progressiveHeight {
//            return (view.frame.height / 2) * (1.0 / CGFloat(numberOfBars))
//        } else {
//            return view.frame.height
//        }
//    }
//    
//    lazy var initialXPosition: CGFloat = {
//        return self.spaceBetweenBars
//    }()
//    
//    private var incrementalXPosition: CGFloat = 0.0
//    private var incrementalHeight: CGFloat = 0.0
//    
//    lazy var halfNumberOfBars: CGFloat = CGFloat(numberOfBars) / 2.0
//    
//    // MARK: Colors
//    let initialColor: UIColor = UIColor.red
//    let middleColor: UIColor = UIColor.green
//    let finalColor: UIColor = UIColor.red
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        progressiveHeight = true
//        spaceBetweenBars = (view.frame.width / 2) / CGFloat(numberOfBars)
//        
//        createView()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func createView() {
//        
//        incrementalXPosition = initialXPosition
//        incrementalHeight = initialBarHeight
//        
//        for i in 0..<numberOfBars {
//            
//            incrementalHeight = barHeight(atIndex: i)
//            
//            let frame = CGRect(x: incrementalXPosition,
//                               y: view.frame.height - incrementalHeight,
//                               width: barWidth,
//                               height: incrementalHeight)
//            let color = interpolateColor(forBarAt: i)
//            let bar = createBar(frame: frame, bgColor: color)
//            
//            incrementalXPosition += barWidth + spaceBetweenBars
//            
//            view.addSubview(bar)
//        }
//    }
//    
//    fileprivate func createBar(frame: CGRect, bgColor color: UIColor) -> ChartBar {
//        let chartBar: ChartBar = ChartBar(frame: frame)
//        chartBar.setColor(color)
//        chartBar.foregroundBar.backgroundColor = color
//        return chartBar
//    }
//    
//    fileprivate func interpolateColor(forBarAt index: Int) -> UIColor {
//        let color: UIColor
//        
//        if CGFloat(index) < halfNumberOfBars {
//            color = UIColor.interpolate(from: initialColor, to: middleColor, with: progress * (CGFloat(index)))
//        } else {
//            color = UIColor.interpolate(from: middleColor, to: finalColor, with: progress * CGFloat(index - Int(halfNumberOfBars)))
//        }
//        return color
//    }
//    
//    fileprivate func barHeight(atIndex index: Int) -> CGFloat {
//        if progressiveHeight {
//            return initialBarHeight * CGFloat(index + 1)
//        }
//        return view.frame.height
//    }
//}
