//
//  PurchaseController.swift
//  PDM
//
//  Created by HOLLEY on 15/10/30.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import UIKit

class PurchaseController: UITableViewController {
    
    @IBOutlet weak var lbCustomerNo: UILabel!

    @IBOutlet weak var lbCustomerName: UILabel!
    
    @IBOutlet weak var lbAddress: UILabel!
    
    @IBOutlet weak var lbMeterNo: UILabel!
    
    @IBOutlet weak var lbLastPurchaseTime: UILabel!
    
    var currentCustomer : Customer! {
        willSet(newCustomer){
            print(newCustomer.customerName)
        }
        didSet{
           print(currentCustomer.customerName)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.tableFooterView = UIView()
        
        lbCustomerNo.text = "Customer No: \(currentCustomer.customerNo)"
        lbCustomerName.text = "Customer Name: \(currentCustomer.customerName)"
        lbAddress.text = "\(currentCustomer.address)"
        lbMeterNo.text = "\(currentCustomer.meters[0].meterNo)"
        lbLastPurchaseTime.text = "\(currentCustomer.lastPurchaseTime)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        switch section{
//        case 0:
//            return 5
//        case 1:
//            return 1
//        default:
//            return 0
//            
//        }
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
