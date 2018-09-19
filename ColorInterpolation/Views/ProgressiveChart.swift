//
//  ProgressiveChart.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 16/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

public class ProgressiveChart: UIView {
    
    fileprivate weak var dataSource: ProgressiveChartDataSource?
    fileprivate weak var delegate: ProgressiveChartDelegate?
    
    fileprivate var bars: [ChartBar] = []
    
    lazy var numberOfSections: Int = {
        guard let dataSourceUnwrapped = dataSource else { return 0 }
        return dataSourceUnwrapped.progressiveChartNumberOfSections(forChart: self)
    }()
    
    private var numberOfBarsPerSection: [Int: Int] = [:]
    
    fileprivate lazy var numberOfBars: Int = {
        guard numberOfSections > 0,
            let dataSourceUnwrapped = dataSource else { return 0 }
        
        for section in 0..<numberOfSections {
            let numberOfBars = dataSourceUnwrapped.progressiveChartNumberOfBars(forChart: self, atSection: section)
            
            numberOfBarsPerSection[section] = numberOfBars
        }
        
        return numberOfBarsPerSection.values.reduce(0, +)
    }()
    
    fileprivate lazy var colorBars: [UIColor] = {
        
        guard numberOfSections > 0,
            let delegateUnwrapped = delegate else { return [] }
        
        var colors: [UIColor] = []
        for section in 0..<numberOfSections  {
            guard let barsCount = numberOfBarsPerSection[section],
                barsCount > 0 else { return [] }
            for bar in 0..<barsCount {
                let color: UIColor = delegateUnwrapped.progressiveChartColorForBar(chart: self, atSection: section, inIndex: bar)
                colors.append(color)
            }
        }
        return colors
    }()
    
    fileprivate var chartSize: CGSize {
        return frame.size
    }
    
    fileprivate var spaceBetweenBars: CGFloat {
        guard let delegateUnwrapped = delegate else { return 0.0 }
        var v = delegateUnwrapped.progressiveChartSpaceBetweenBars(forChart: self)
        let limitValue = chartSize.width / CGFloat(numberOfBars)
        if v > limitValue {
            v = limitValue
        }
        return v
    }
    
    fileprivate var totalGapsScpace: CGFloat {
        return spaceBetweenBars * CGFloat(numberOfBars + 1)
    }
    
    fileprivate var availableWidth: CGFloat {
        return chartSize.width - totalGapsScpace
    }
    
    fileprivate var availableHeight: CGFloat {
        return frame.height - sectionSeparatorHeight - titleLabelHeight
    }
    
    fileprivate lazy var barWidth: CGFloat = {
        return availableWidth / CGFloat(numberOfBars)
    }()
    
    fileprivate lazy var progress: CGFloat = {
        if numberOfBars > 3 {
            return 2 / CGFloat(numberOfBars)
        } else {
            return 3 / CGFloat(numberOfBars)
        }
    }()
    
    /**
     When true the bars are created with increasing height,
     when false the bars are all created with the same height.
     * The default value is false
     */
    var progressiveHeight: Bool = false
    
    private var initialBarHeight: CGFloat {
        
        if progressiveHeight {
            return (availableHeight * 0.9) * (1.0 / CGFloat(numberOfBars))
        } else {
            return availableHeight
        }
    }
    
    fileprivate var initialXPosition: CGFloat {
        return spaceBetweenBars
    }
    
    fileprivate lazy var initialYPosition: CGFloat = {
        return availableHeight - spaceBetweenSeparatorAndBars
    }()
    
    private var incrementalXPosition: CGFloat = 0.0
    private var incrementalHeight: CGFloat = 0.0
    
    fileprivate lazy var halfNumberOfBars: CGFloat = CGFloat(numberOfBars) / 2.0
    
    // MARK: Separators
    fileprivate let sectionSeparatorHeight: CGFloat = 7.0
    fileprivate let spaceBetweenSeparatorAndBars: CGFloat = 2.0
    
    fileprivate lazy var separatorsInitialYPosition: CGFloat = {
        return titleInitialYPosition - sectionSeparatorHeight
    }()
    
    // MARK: Titles
    
    fileprivate let titleLabelHeight: CGFloat = 15.0
    
    fileprivate lazy var titleInitialYPosition: CGFloat = {
        return frame.height - titleLabelHeight
    }()
    
    fileprivate lazy var titles: [String] = {
        
        guard numberOfSections > 0,
            let dataSourceUnwrapped = dataSource else { return [] }
        
        var titles: [String] = []
        
        for section in 0..<numberOfSections {
            let title: String = dataSourceUnwrapped.progressiveChartTitleForSection(section: section)
            titles.append(title)
        }
        return titles
    }()
    
    // MARK: Colors
    let initialColor: UIColor = UIColor(red: 140/255, green: 74/255, blue: 14/255, alpha: 1)
    let middleColor: UIColor = UIColor.green
    let finalColor: UIColor = UIColor.black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func set(dataSource: ProgressiveChartDataSource, andDelegate delegate: ProgressiveChartDelegate) {
        self.dataSource = dataSource
        self.delegate = delegate
        
        createView()
    }
    
    fileprivate func createView() {
        
        incrementalXPosition = initialXPosition
        incrementalHeight = initialBarHeight
        
        for i in 0..<numberOfBars {
            
            incrementalHeight = barHeight(atIndex: i)
            
            let frame = CGRect(x: incrementalXPosition,
                               y: initialYPosition - incrementalHeight,
                               width: barWidth,
                               height: incrementalHeight)
            
            let bar = createBar(frame: frame)
            
            incrementalXPosition += barWidth + spaceBetweenBars
            
            bars.append(bar)
            
            addSubview(bar)
        }
        
        drawSectionsSeparators()
        setSectionsTitle()
    }
    
    fileprivate func createBar(frame: CGRect, bgColor color: UIColor = UIColor.clear) -> ChartBar {
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

//*******************************************************************************
//
// MARK: - Separators Extension
//
//*******************************************************************************
fileprivate extension ProgressiveChart {
    
    fileprivate func drawSectionsSeparators() {
        
        var x = initialXPosition
        
        for section in 0..<numberOfBarsPerSection.count {
            
            let bars = numberOfBarsAt(section: section)
            let totalGapsWidth: CGFloat = spaceBetweenBars * CGFloat(bars - 1)
            let totalBarsWidth: CGFloat = barWidth * CGFloat(bars)
            
            let lineWidth = totalGapsWidth + totalBarsWidth
            
            let lineRect: CGRect = CGRect(x: x,
                                          y: separatorsInitialYPosition,
                                          width: lineWidth,
                                          height: sectionSeparatorHeight)
            
            let line = SectionSeparator(frame: lineRect)
            
            addSubview(line)
            
            x += lineWidth + spaceBetweenBars
        }
    }
    
    fileprivate func numberOfBarsAt(section: Int) -> Int {
        return numberOfBarsPerSection[section] ?? 0
    }
}

//*******************************************************************************
//
// MARK: - Ranges titles Extension
//
//*******************************************************************************
fileprivate extension ProgressiveChart {
    fileprivate func setSectionsTitle() {
        
        var xPosition = initialXPosition
        
        for section in 0..<numberOfBarsPerSection.count {
            
            let bars = numberOfBarsAt(section: section)
            let totalGapsWidth: CGFloat = spaceBetweenBars * CGFloat(bars - 1)
            let totalBarsWidth: CGFloat = barWidth * CGFloat(bars)
            
            let labelWidth = totalGapsWidth + totalBarsWidth
            
            let labelRect: CGRect = CGRect(x: xPosition,
                                           y: titleInitialYPosition,
                                           width: labelWidth,
                                           height: 15.0)
            
            let titleLabel = UILabel(frame: labelRect)
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.minimumScaleFactor = 0.5
            titleLabel.font = UIFont.boldSystemFont(ofSize: 10)
            titleLabel.textAlignment = NSTextAlignment.center
            titleLabel.text = titles[section]
            
            addSubview(titleLabel)
            
            xPosition += labelWidth + spaceBetweenBars
        }
    }
}

//*******************************************************************************
//
// MARK: - Progress Animation at Extension
//
//*******************************************************************************
extension ProgressiveChart {
    
    //0.0 - 1.0
    public func setTotalProgressAt(_ percentage: Double) {
        
        let percentageToWork: Double = max(0, min(percentage, 1))
        
        let numberOfBarsFraction: Double = percentageToWork * Double(numberOfBars)
        let numberOfBarsIntegerToFill: Int = Int(floor(numberOfBarsFraction))
        
        for (index, bar) in bars.enumerated() {
            
            if index == numberOfBarsIntegerToFill { break }
            
            bar.setColor(colorBars[index])
            bar.setHeightPercentage(1)
        }
        
        let remainder: Double = (numberOfBarsFraction)
            .truncatingRemainder(dividingBy: Double(numberOfBarsIntegerToFill))
        
        if remainder != 0 && !remainder.isNaN {
            let lastBarToFill = bars[numberOfBarsIntegerToFill]
            let barPercentage: CGFloat = CGFloat(remainder)
            
            lastBarToFill.setColor(colorBars[numberOfBarsIntegerToFill])
            lastBarToFill.setHeightPercentage(barPercentage)
        }
    }
    
    func setProgress(forSection section: Int, atPercentage percentage: Double) {
        
        let sectionToWork = max(0, min(section, numberOfSections - 1))
        let percentageToWork: Double = max(0, min(percentage, 1))
        
        var sumOfBars: Int = Int(floor(Double(numberOfBarsAt(section: sectionToWork)) * percentageToWork))
        
        for sec in 0..<sectionToWork {
            sumOfBars += numberOfBarsAt(section: sec)
        }
        
        setTotalProgressAt(Double(sumOfBars) / 20.0)
    }
}
