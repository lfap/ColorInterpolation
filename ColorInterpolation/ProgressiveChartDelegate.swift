//
//  ProgressiveChartDelegate.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 16/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
import UIKit

protocol ProgressiveChartDelegate: class {
    
    /**
     Asks the delegate for the space between the bars, this method is not required, if you don't implement it the default value is 0.0
     */
    func progressiveChartSpaceBetweenBars(forChart chart: ProgressiveChart) -> CGFloat
    
    /**
     Asks the delegate for the color to be used at a given index
     
     - section: The section in wich the bar is placed
     - index: The index of the bar in the given section
     */
    func progressiveChartColorForBar(chart: ProgressiveChart, atSection section: Int, inIndex index: Int) -> UIColor
    
}

extension ProgressiveChartDelegate {
    func progressiveChartSpaceBetweenBars(forChart chart: ProgressiveChart) -> CGFloat {
        return 0.0
    }
    
    func progressiveChartColorForBar(chart: ProgressiveChart, atSection section: Int, inIndex index: Int) -> UIColor {
        return UIColor.black
    }
}

