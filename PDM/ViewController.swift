//
//  ViewController.swift
//  PDM
//
//  Created by HOLLEY on 15/10/30.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class LoginViewController: UIViewController {
    
    var currentCustomer: Customer!
    
    
    @IBOutlet weak var tbCustomerNo: UITextField!
    
    
    @IBOutlet weak var tbPassword: UITextField!
    
    
    @IBOutlet weak var btLogin: ZFRippleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ConfigView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: ZFRippleButton) {
        login()
    }
    
    func ConfigView(){
        
        //设置户号选中
        self.tbCustomerNo.becomeFirstResponder()
        
        let passwordImg = UIImageView(image: UIImage(named: "icon_user"))
        self.tbPassword.rightView = passwordImg
        self.tbPassword.rightViewMode = .Always
        
    }
    
    
    @IBAction func finishCustomerNoInput(sender: UITextField) {
        self.tbPassword.becomeFirstResponder()
        
    }
    
    @IBAction func finishPasswordInput(sender: UITextField) {
        login()
    }
    
    
    func login()
    {
        //ProgressHUD.show("Login, Please wait...")
        self.view.pleaseWait()
        Alamofire.request(Router.CustomerLogin(self.tbCustomerNo.text!, self.tbPassword.text!)).responseObject { (response :Customer?, error: ErrorType?) -> Void in
            if let customer = response {
                print(customer.meters[0].meterNo)
                if let _ = customer.customerId {
                    self.currentCustomer = customer
                    //ProgressHUD.showSuccess("Login Success")
                    self.view.noticeSuccess("Success", autoClear: true, autoClearTime: 2)
                    
                    self.performSegueWithIdentifier("gotoMain", sender: self)
                }
                else{
                    //ProgressHUD.showError("Login Failed", interaction: true)
                    self.view.noticeError("Failed", autoClear: true, autoClearTime: 2)
                }
                
            }
            else
            {
                //ProgressHUD.showError("Login Failed", interaction: true)
                self.view.noticeError("Failed", autoClear: true, autoClearTime: 2)
            }
        }
        //        ProgressHUD.show("Login, Please wait...")
        //        self.Delay(2, closure: { () -> () in
        //            ProgressHUD.showSuccess("Login Success")
        //            self.performSegueWithIdentifier("gotoMain", sender: self)
        //        })
    }
    
    func Delay(time:Double,closure:()->()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tabBarController = segue.destinationViewController as! RAMAnimatedTabBarController
        let navigationController0 = tabBarController.viewControllers![0] as! UINavigationController
        let purchaseController = navigationController0.topViewController as! PurchaseController
        
        let navigationController1 = tabBarController.viewControllers![1] as! UINavigationController
        let orderViewcontroller = navigationController1.topViewController as! OrdersViewController
        
        let navigationController2 = tabBarController.viewControllers![2] as! UINavigationController
        let consumptionViewController = navigationController2.topViewController as! ConsumptionViewController
        
        print(self.currentCustomer.meters[0].meterId)
        
        purchaseController.currentCustomer = self.currentCustomer
        orderViewcontroller.currentCustomer = self.currentCustomer
        consumptionViewController.currentCustomer = self.currentCustomer
    }
}

