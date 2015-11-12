//
//  ConsumptionViewController.swift
//  PDM
//
//  Created by HOLLEY on 15/10/30.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import AlamofireObjectMapper

class ConsumptionViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,ChartViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chartView: BarChartView!
    
    var currentPageIndex = 1
    let pageCount = 20
    
    var billingList = [Billing]()
    
    @IBAction func RefreshData(sender: UIBarButtonItem) {
        LoadData()
    }
    
    
    var currentCustomer : Customer! {
        willSet(newCustomer){
            print(newCustomer.customerName)
        }
        didSet{
            print(currentCustomer.customerName)
        }
    }
    
    
    @IBAction func selectSegChanged(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            self.tableView.hidden = true
            self.chartView.hidden = false
            
        case 1:
            self.tableView.hidden = false
            self.chartView.hidden = true
        default:
            break
        }
    }
    
    @IBOutlet weak var selectSeg: UISegmentedControl!
    
    var consumptionChartView: ConsumptionChartView?
    
    var consumptionTableView: ConsumptionTableView?
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        configChartView()
        
        self.chartView.hidden = false
        self.tableView.hidden = true
    }
    
    func configChartView(){
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
        leftAxis.valueFormatter!.negativeSuffix = " ￠";
        leftAxis.valueFormatter!.positiveSuffix = " ￠";
        leftAxis.labelPosition = .OutsideChart;
        leftAxis.spaceTop = 0.15;
        
        let rightAxis = self.chartView.rightAxis;
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
        
        LoadData()
    }
    
    
    func configTableView()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //        self.tableView.registerClass(OrderTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
        let header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.headRefresh()
        })
        
        header.setTitle("Pull down to refresh", forState: MJRefreshStateIdle)
        header.setTitle("Release to refresh", forState: MJRefreshStatePulling)
        header.setTitle("Loading ...", forState: MJRefreshStateRefreshing)
        
        header.lastUpdatedTimeLabel?.hidden = true
        
        self.tableView.header = header
        
        
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            self.footRefresh()
        })
        
        footer.setTitle("Click or drag up to refresh", forState: MJRefreshStateIdle)
        footer.setTitle("Loading more....", forState: MJRefreshStateRefreshing)
        footer.setTitle("No more data", forState: MJRefreshStateNoMoreData)
        
        
        self.tableView.footer = footer
        
        self.tableView.header.beginRefreshing()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 返回表格行数（也就是返回控件数）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.billingList.count
    }
    
    // 创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        // 为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "cell"
        // 同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as! MonthConsumptionTableViewCell
        
        //设置cell的显示动画为3D缩放
        //xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        //设置动画时间为0.25秒，xy方向缩放的最终值为1
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
        })
        
        
        
        cell.lbTime.text = self.billingList[indexPath.row].Time
        cell.lbConsumptionMoney.text = self.billingList[indexPath.row].ConsumptionMoney
        cell.lbConsumptionkWh.text = self.billingList[indexPath.row].ConsumptionkWh
        
        if Double(self.billingList[indexPath.row].Balance) < 0{
            cell.lbBalance.backgroundColor = UIColor.redColor()
        }
        else{
            cell.lbBalance.backgroundColor = UIColor.greenColor()

        }
        cell.lbBalance.text = self.billingList[indexPath.row].Balance
        
        return cell
    }
    
    
    func headRefresh(){
        if self.currentCustomer.meters.count>0 {
            Alamofire.request(Router.GetBillingDataList(self.currentCustomer.meters[0].meterId, 1, self.pageCount)).responseArray { (billList : [Billing]?, error: ErrorType?) -> Void in
                
                
                if let list = billList{
                    self.billingList.removeAll(keepCapacity: false)
                    self.currentPageIndex = 1
                    
                    self.billingList = list
                    self.tableView.header.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    func footRefresh(){
        self.currentPageIndex = self.currentPageIndex + 1
        if self.currentCustomer.meters.count>0 {
            Alamofire.request(Router.GetBillingDataList(self.currentCustomer.meters[0].meterId, self.currentPageIndex, self.pageCount)).responseArray { (billList : [Billing]?, error: ErrorType?) -> Void in
                
                if let list = billList{
                    for order in list{
                        self.billingList.append(order)
                    }
                    
                    self.tableView.footer.endRefreshing()
                    self.tableView.reloadData()
                }
                else{
                    self.tableView.footer.endRefreshingWithNoMoreData()
                }
                
            }
        }
    }
    
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        NSLog("chartValueSelected");
    }
    
    
    func LoadData()
    {
        self.chartView.pleaseWait()
        if self.currentCustomer.meters.count>0
        {
            Alamofire.request(Router.GetConsumptionAmountByMonth(self.currentCustomer.meters[0].meterId)).responseArray{
                (energyList : [MonthConsumption]?, error: ErrorType?) -> Void in
                
                if let list = energyList{
                    self.setChart(list)
                    self.chartView.noticeSuccess("Finished", autoClear: true, autoClearTime: 2)
                }
                else
                {
                    self.chartView.noticeError("Failed", autoClear: true, autoClearTime: 2)
                }
            }
        }
    }
    
    func setChart(monthorderlist:[MonthConsumption]){
        var dataEntries:[BarChartDataEntry] = []
        var xValues:[String] = []
        
        for i in 0..<monthorderlist.count{
            let dataEntry = BarChartDataEntry(value: monthorderlist[i].ConsumptionMoney, xIndex: i)
            dataEntries.append(dataEntry)
            xValues.append(monthorderlist[i].Month)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Monthly Consumption")
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = BarChartData(xVals: xValues, dataSet: chartDataSet)
        self.chartView.data = chartData
        self.chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
