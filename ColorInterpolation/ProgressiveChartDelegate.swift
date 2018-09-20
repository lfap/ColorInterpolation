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
     
     > The default is black
     
     - section: The section in wich the bar is placed
     - index: The index of the bar in the given section
     */
    func progressiveChartColorForBar(chart: ProgressiveChart, atSection section: Int, inIndex index: Int) -> UIColor
    
    /**
     Asks the delegate for the color to be used at a given section title
     
     > The default is black
     
    section: The section that the title is
     */
    func progressiveChartColorForTitle(chat: ProgressiveChart, atSection section: Int) -> UIColor?
    
    /**
     Asks the delegate for the alpha value, between 0.0 and 1.0, to use for the sections titles and separators when they are not used.
     > When the char was only 2 sections and only the first sections has bars filled the title ans separator for the second section will have a lower alpha value
     
     > The default value is 0.5
     */
    func progressiveChartAlphaForUnusedSections(chat: ProgressiveChart) -> CGFloat
}

extension ProgressiveChartDelegate {
    
    func progressiveChartSpaceBetweenBars(forChart chart: ProgressiveChart) -> CGFloat {
        return 0.0
    }
    
    func progressiveChartColorForBar(chart: ProgressiveChart, atSection section: Int, inIndex index: Int) -> UIColor {
        return UIColor.black
    }
    
    func progressiveChartColorForTitle(chat: ProgressiveChart, atSection section: Int) -> UIColor? {
        return UIColor.black
    }
    
    func progressiveChartAlphaForUnusedSections(chat: ProgressiveChart) -> CGFloat {
        return 0.5
    }
}

