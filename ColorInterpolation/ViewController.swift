//
//  ViewController.swift
//  ColorInterpolation
//
//  Created by Luiz Felipe Albernaz Pio on 13/09/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    var progressiveChart: ProgressiveChart!
    
    let titles: [String] = ["-18.5", "18.6 - 24.9", "25 - 29.9", "30 - 35+"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        containerView.backgroundColor = UIColor.clear
        let chartFrame = CGRect(origin: CGPoint.zero, size: containerView.frame.size)
        progressiveChart = ProgressiveChart(frame: chartFrame)
        
        progressiveChart.progressiveHeight = true
        
        progressiveChart.set(dataSource: self, andDelegate: self)
        
        containerView.addSubview(progressiveChart)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTouchGeneratePercentage(_ button: UIButton) {
        let value = Double.random(in: 0.0...1.0)
        valueLabel.text = String(format: "%.2f", value)
        progressiveChart.setTotalProgressAt(value)
    }
}

extension ViewController: ProgressiveChartDataSource {
    func progressiveChartNumberOfSections(forChart chart: ProgressiveChart) -> Int {
        return titles.count
    }
    
    func progressiveChartNumberOfBars(forChart chart: ProgressiveChart, atSection section: Int) -> Int {
        
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
    
    func progressiveChartAlphaForUnusedSections(chat: ProgressiveChart) -> CGFloat {
        return 0.0
    }
}
