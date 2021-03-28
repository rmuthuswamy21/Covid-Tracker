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
    var averageCases = 0.0
    
    var chart: BarsChart?
    var cases: Double = 0.0
    var casesBefore:Double = 0.0
    var deathsBefore:Double = 0.0
    var deaths:Double = 0.0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawChart()
    }
    func calculateMax() -> Double {
        var maximum = max(averageCases, cases)
        maximum = ceil (maximum/100) * 100
        
        return maximum
        
    }
    
    func drawChart() {
        cases = Double(covidStateModel?.positive ?? 0)
        deaths = Double(covidStateModel?.death ?? 0)
        let max = calculateMax()
        let by = ceil (max/100) * 10
        print(by)
        
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: max + by, by: by)
        )

        let frame = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: 500)
        
        
        let chart = BarsChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "State: \(stateNameConversion[covidStateModel?.state ?? " "] ?? " ")",
            yTitle: "Number of Positive Cases",
            bars: [
                
                
                ("Average", averageCases),
                ("Cases-Current", (cases) ),
                
                
            ],
            color: UIColor.red,
            barWidth: 50
        )

        self.view.addSubview(chart.view)
        self.chart = chart
    }
    
    
}
