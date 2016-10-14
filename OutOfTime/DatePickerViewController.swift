//
//  DatePickerViewController.swift
//  OuttaTimeRedux
//
//  Created by Ross Gottschalk on 8/15/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController
{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: SetDestinationDelegate?
    let dateFormat = DateFormatter()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Action Handlers
    
    @IBAction func enterPressed(_ sender: UIButton)
    {
        delegate?.didFinish(dateSet: datePicker.date as Date)
        dismiss(animated: true, completion: nil)
    }
//    @IBAction func enterDateTapped(sender: UIButton)
//    {
//        delegate?.didFinish(dateSet: datePicker.date as NSDate)
//        dismiss(animated: true, completion: nil)
//    }
//
    @IBAction func cancelPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
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
