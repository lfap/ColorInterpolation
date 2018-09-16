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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chartFrame = CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: view.frame.height / 2)
        progressiveChart = ProgressiveChart(frame: chartFrame)
        progressiveChart.dataSource = self
        view.addSubview(progressiveChart)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ProgressiveChartDataSource {
    func progressiveChartNumberOfSections(forChart chart: ProgressiveChart) -> Int {
        return 1
    }
    
    func progressiveChartNumberOfBars(forChart chart: ProgressiveChart, atSection: Int) -> Int {
        return 20
    }
    
    func progressiveChartTitleForSection(section: Int) -> String {
        return "Title"
    }r
}
