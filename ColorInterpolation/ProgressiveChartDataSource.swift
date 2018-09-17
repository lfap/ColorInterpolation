//
//  ProgressiveChartDataSource.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 16/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

protocol ProgressiveChartDataSource: class {
    
    func progressiveChartNumberOfSections(forChart chart: ProgressiveChart) -> Int
    
    func progressiveChartNumberOfBars(forChart chart: ProgressiveChart, atSection section: Int) -> Int
    
    func progressiveChartTitleForSection(section: Int) -> String 
}
