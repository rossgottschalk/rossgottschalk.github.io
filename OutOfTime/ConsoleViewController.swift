//
//  ConsoleViewController.swift
//  OutOfTime
//
//  Created by Ross Gottschalk on 10/14/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit
protocol SetDestinationDelegate
{
    func didFinish(dateSet: Date)
}
class ConsoleViewController: UIViewController, SetDestinationDelegate
{
    @IBOutlet weak var destinationDateLabel: UILabel!
    @IBOutlet weak var presentDateLabel: UILabel!
    @IBOutlet weak var lastDateLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    let dateFormat = DateFormatter()
    var speedTimer = Timer()
    var currentSpeed: Int = 0
    var startingSpeed: Int = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Outta Time"
        
        
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .none
        let todaysDate = Date()
        presentDateLabel.text = dateFormat.string(from: todaysDate as Date)
        destinationDateLabel.text = "?????"


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "datePickerSegue"
        {
            let datePickerVC = segue.destination as! DatePickerViewController
            datePickerVC.delegate = self
        }

    }
    
    
    //MARK: - Action Handlers
    
    @IBAction func travelBackTapped(sender: AnyObject)
    {
        speedTimer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector (ConsoleViewController.travelBackStarted), userInfo: nil, repeats: true)
    }
    
    func travelBackStarted()
    {
        if (startingSpeed < 88)
        {
            startingSpeed = startingSpeed + 1
            speedLabel.text = "\(startingSpeed)MPH"
        }
        else
        {
            speedTimer.invalidate()
            startingSpeed = 0
            speedLabel.text = "-- MPH"
            lastDateLabel.text = presentDateLabel.text
            presentDateLabel.text = destinationDateLabel.text
            destinationDateLabel.text = "Pick A New Date"
        }
    }
    
    func didFinish(dateSet: Date)
    {
        destinationDateLabel.text = dateFormat.string(from: dateSet)
    }

    

}
