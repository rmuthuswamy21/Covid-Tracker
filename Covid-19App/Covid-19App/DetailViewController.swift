//
//  DetailViewController.swift
//  Covid-19App
//
//  Created by Rahul Muthuswamy on 2/28/21.
//

import Foundation
import UIKit
import SwiftCharts

class DetailViewController: UIViewController {
    var covidStateModel: StateCovidModel?
    var chart: BarsChart?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawChart()
    }
    
    func drawChart() {
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )

        let frame = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: 500)
                
        let chart = BarsChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            bars: [
                ("A", 2),
                ("B", 4.5),
                ("C", 3),
                ("D", 5.4),
                ("E", 6.8),
                ("F", 0.5)
            ],
            color: UIColor.red,
            barWidth: 20
        )

        self.view.addSubview(chart.view)
        self.chart = chart
    }
    
    
}
