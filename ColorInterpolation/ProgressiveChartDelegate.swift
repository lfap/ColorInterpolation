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

    func progressiveChartSpaceBetweenBars(forChart chart: ProgressiveChart) -> CGFloat    
}

extension ProgressiveChartDelegate {
    func progressiveChartSpaceBetweenBars(forChart chart: ProgressiveChart) -> CGFloat {
        return 0.0
    }
}

