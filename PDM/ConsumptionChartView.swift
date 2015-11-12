//
//  ConsumptionChartView.swift
//  PDM
//
//  Created by HOLLEY on 15/11/3.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import UIKit
import Charts

class ConsumptionChartView: UIView,ChartViewDelegate {
    
    var months: [String]!
    
    @IBOutlet weak var chartView: BarChartView!
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("__FUNCTION__")
            }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("___FUNCTION___")

    }
    
    override func awakeFromNib() {

        self.chartView.delegate = self;
        
        self.chartView.descriptionText = "";
        self.chartView.noDataTextDescription = "";
        
        self.chartView.drawBarShadowEnabled = false;
        self.chartView.drawValueAboveBarEnabled = true;
        
        self.chartView.maxVisibleValueCount = 60;
        self.chartView.pinchZoomEnabled = false;
        self.chartView.drawGridBackgroundEnabled = false;
        
        
        let xAxis = self.chartView.xAxis;
        xAxis.labelPosition = .BothSided;
        xAxis.labelFont = UIFont.systemFontOfSize(10);
        xAxis.drawGridLinesEnabled = false;
        xAxis.spaceBetweenLabels = 2;
        
        let leftAxis = self.chartView.leftAxis;
        leftAxis.labelFont = UIFont.systemFontOfSize(10);
        leftAxis.labelCount = 8;
        leftAxis.valueFormatter = NSNumberFormatter()
        leftAxis.valueFormatter!.maximumFractionDigits = 1;
        leftAxis.valueFormatter!.negativeSuffix = " kWh";
        leftAxis.valueFormatter!.positiveSuffix = " kWh";
        leftAxis.labelPosition = .OutsideChart;
        leftAxis.spaceTop = 0.15;
        
        let rightAxis = self.chartView.rightAxis
        rightAxis.drawGridLinesEnabled = false;
        rightAxis.labelFont = UIFont.systemFontOfSize(10);
        rightAxis.labelCount = 8;
        rightAxis.valueFormatter = leftAxis.valueFormatter;
        rightAxis.spaceTop = 0.15;
        
        self.chartView.legend.position = .BelowChartLeft;
        self.chartView.legend.form = .Square;
        self.chartView.legend.formSize = 9.0;
        self.chartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 11.0)!
        self.chartView.legend.xEntrySpace = 4.0;
        

        
        //LoadData()

       
    }
    
    func Delay(time:Double,closure:()->()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    func LoadData()
    {
        print(__COLUMN__ ,__FILE__, __FUNCTION__, __LINE__)
        //months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        months = ["2015-11", "2015-11", "2015-11", "2015-11", "2015-11", "2015-11", "2015-11", "2015-11", "2015-11", "2015-11", "2015-11", "2015-11"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        
        //ProgressHUD.show("Loading Data...")
        self.pleaseWait()
        self.Delay(2) { () -> () in
            //ProgressHUD.showSuccess("Loading Finished.")
            self.noticeSuccess("Finished", autoClear: true, autoClearTime: 2)
            self.setChart(self.months, values: unitsSold)
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        //self.chartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        self.chartView.data = chartData
        self.chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
    }
    
    func setChart(monthlist:[MonthConsumption]){
        var dataEntries:[BarChartDataEntry] = []
        var xValues:[String] = []
        
        for i in 0..<monthlist.count{
            let dataEntry = BarChartDataEntry(value: monthlist[i].ConsumptionMoney, xIndex: i)
            dataEntries.append(dataEntry)
            xValues.append(monthlist[i].Month)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Monthly Purchase")
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = BarChartData(xVals: xValues, dataSet: chartDataSet)
        self.chartView.data = chartData
        self.chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        NSLog("chartValueSelected");
    }

}
