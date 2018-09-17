//
//  ViewController.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 13/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var progressiveChart: ProgressiveChart!
    
    let titles: [String] = ["-18.5", "18.6 - 24.9", "25 - 29.9", "30 - 35+"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chartFrame = CGRect(x: 0, y: view.frame.height / 4, width: view.frame.width, height: view.frame.height * 0.75)
        progressiveChart = ProgressiveChart(frame: chartFrame)
        
        progressiveChart.progressiveHeight = true
        
        progressiveChart.set(dataSource: self, andDelegate: self)
        
        view.addSubview(progressiveChart)
        
        progressiveChart.setProgressAt(0.55)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ProgressiveChartDataSource {
    func progressiveChartNumberOfSections(forChart chart: ProgressiveChart) -> Int {
        //return titles.count
        return 2
    }
    
    func progressiveChartNumberOfBars(forChart chart: ProgressiveChart, atSection section: Int) -> Int {
        
        return 5
        
        if section < 2 {
            return 4
        } else {
            return 6
        }
    }
    
    func progressiveChartTitleForSection(section: Int) -> String {
        return titles[section]
    }
}

extension ViewController: ProgressiveChartDelegate {
    func progressiveChartSpaceBetweenBars(forChart chart: ProgressiveChart) -> CGFloat {
        return 10
    }
}
