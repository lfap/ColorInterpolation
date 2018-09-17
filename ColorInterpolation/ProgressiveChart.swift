//
//  ProgressiveChart.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 16/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class ProgressiveChart: UIView {
    
    weak var dataSource: ProgressiveChartDataSource? {
        didSet {
            createView()
        }
    }
    
    lazy var numberOfSections: Int = {
        guard let dataSourceUnwrapped = dataSource else { return 0 }
        return dataSourceUnwrapped.progressiveChartNumberOfSections(forChart: self)
    }()
    
    private var numberOfBarsPerSection: [Int: Int] = [:]
    
    lazy var numberOfBars: Int = {
        guard numberOfSections > 0,
            let dataSourceUnwrapped = dataSource else { return 0 }
                
        for section in 0..<numberOfSections {
            let numberOfBars = dataSourceUnwrapped.progressiveChartNumberOfBars(forChart: self, atSection: section)
            
            numberOfBarsPerSection[section] = numberOfBars
        }
        
        return numberOfBarsPerSection.values.reduce(0, +)
    }()
    
    lazy var chartSize: CGSize = {
        return frame.size
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
    
    lazy var availableHeight: CGFloat = {
        return frame.height - sectionSeparatorHeight
    }()
    
    lazy var barWidth: CGFloat = {
        return availableWidth / CGFloat(numberOfBars)
    }()
    
    lazy var progress: CGFloat = {
        if numberOfBars > 3 {
            return 2 / CGFloat(numberOfBars)
        } else {
            return 3 / CGFloat(numberOfBars)
        }
    }()
    
    let sectionSeparatorHeight: CGFloat = 7.0
    let spaceBetweenSeparatorAndBars: CGFloat = 2.0
    
    private var progressiveHeight: Bool = false
    
    private var initialBarHeight: CGFloat {
        
        if progressiveHeight {
            return (availableHeight / 2) * (1.0 / CGFloat(numberOfBars))
        } else {
            return availableHeight
        }
    }
    
    lazy var initialXPosition: CGFloat = {
        return self.spaceBetweenBars
    }()
    
    lazy var initialYPosition: CGFloat = {
        return availableHeight - spaceBetweenSeparatorAndBars
    }()
    
    private var incrementalXPosition: CGFloat = 0.0
    private var incrementalHeight: CGFloat = 0.0
    
    lazy var halfNumberOfBars: CGFloat = CGFloat(numberOfBars) / 2.0
    
    // MARK: Colors
    let initialColor: UIColor = UIColor.red
    let middleColor: UIColor = UIColor.green
    let finalColor: UIColor = UIColor.red
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func createView() {
        
        incrementalXPosition = initialXPosition
        incrementalHeight = initialBarHeight
        
        for i in 0..<numberOfBars {
            
            incrementalHeight = barHeight(atIndex: i)
            
            let frame = CGRect(x: incrementalXPosition,
                               y: initialYPosition - incrementalHeight,
                               width: barWidth,
                               height: incrementalHeight)
            let color = interpolateColor(forBarAt: i)
            let bar = createBar(frame: frame, bgColor: color)
            
            incrementalXPosition += barWidth + spaceBetweenBars
            
            addSubview(bar)
        }
        
        drawSectionsSeparators()
    }
    
    fileprivate func createBar(frame: CGRect, bgColor color: UIColor) -> ChartBar {
        let chartBar: ChartBar = ChartBar(frame: frame)
        chartBar.setColor(color)
        chartBar.foregroundBar.backgroundColor = color
        return chartBar
    }
    
    fileprivate func interpolateColor(forBarAt index: Int) -> UIColor {
        let color: UIColor
        
        if CGFloat(index) < halfNumberOfBars {
            color = UIColor.interpolate(from: initialColor, to: middleColor, with: progress * (CGFloat(index)))
        } else {
            color = UIColor.interpolate(from: middleColor, to: finalColor, with: progress * CGFloat(index - Int(halfNumberOfBars)))
        }
        return color
    }
    
    fileprivate func barHeight(atIndex index: Int) -> CGFloat {
        if progressiveHeight {
            return initialBarHeight * CGFloat(index + 1)
        }
        return frame.height - 7.0
    }
}

fileprivate extension ProgressiveChart {
    
    func drawSectionsSeparators() {
        
        var x = initialXPosition
        
        for section in 0..<numberOfBarsPerSection.count {
            
            let bars = numberOfBarsAt(section: section)
            
            let lineWidth = barWidth * CGFloat(bars)

            let lineRect: CGRect = CGRect(x: x,
                                          y: availableHeight,
                                          width: lineWidth,
                                          height: sectionSeparatorHeight)
            
            let line = PCSectionSeparator(frame: lineRect)
            
            addSubview(line)
            
            x += lineWidth
        }
    }
    
    func numberOfBarsAt(section: Int) -> Int {
        return numberOfBarsPerSection[section] ?? 0
    }
}
