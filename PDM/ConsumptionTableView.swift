//
//  ConsumptionTableView.swift
//  PDM
//
//  Created by HOLLEY on 15/11/3.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ConsumptionTableView: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    var currentPageIndex = 1
    let pageCount = 20
    
    var billingList = [Billing]()
    
    var currentCustomer : Customer!
    
    override func awakeFromNib() {
        
        self.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView()
        
        let header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.headRefresh()
        })
        
        header.setTitle("Pull down to refresh", forState: MJRefreshStateIdle)
        header.setTitle("Release to refresh", forState: MJRefreshStatePulling)
        header.setTitle("Loading ...", forState: MJRefreshStateRefreshing)
        
        header.lastUpdatedTimeLabel?.hidden = true
        
        self.header = header
        
        
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            self.footRefresh()
        })
        
        footer.setTitle("Click or drag up to refresh", forState: MJRefreshStateIdle)
        footer.setTitle("Loading more....", forState: MJRefreshStateRefreshing)
        footer.setTitle("No more data", forState: MJRefreshStateNoMoreData)
        
        
        self.footer = footer
        
        self.header.beginRefreshing()
        
    }
    
    func headRefresh(){
        
        Alamofire.request(Router.GetBillingDataList(self.currentCustomer.customerId, 1, self.pageCount)).responseArray { (billingList : [Billing]?, error: ErrorType?) -> Void in
            
            
            if let list = billingList{
                self.billingList.removeAll(keepCapacity: false)
                self.currentPageIndex = 1
                
                self.billingList = list
                self.header.endRefreshing()
                self.reloadData()
            }
        }
        
    }
    func footRefresh(){
        self.currentPageIndex = self.currentPageIndex + 1
        Alamofire.request(Router.GetBillingDataList(self.currentCustomer.customerId, self.currentPageIndex, self.pageCount)).responseArray { (billingList : [Billing]?, error: ErrorType?) -> Void in
            
            if let list = billingList{
                for billing in list{
                    self.billingList.append(billing)
                }
                
                self.footer.endRefreshing()
                self.reloadData()
            }
            else{
                self.footer.endRefreshingWithNoMoreData()
            }
            
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.billingList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath)
        
        cell.textLabel?.text = self.billingList[indexPath.row].Time
        
        return cell
    }
}
