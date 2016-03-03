//
//  DetailedViewController.swift
//  CollegeProfileBuilder
//
//  Created by pazar on 1/28/16.
//  Copyright © 2016 Patrick Azar. All rights reserved.
//

import UIKit
import SafariServices

class DetailedViewController: UIViewController, SFSafariViewControllerDelegate
{
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var numberOfStudentsTF: UITextField!
    @IBOutlet weak var webpageTF: UITextField!
    
    //TableView variable?
    
    var university : College!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        nameTF.text = university.name
        locationTF.text = university.location
        numberOfStudentsTF.text = String(university.numberOfStudents)
        myImageView.image = university.image
        webpageTF.text = university.webpage
        


    }
    @IBAction func saveButtonTapped(sender: UIButton)
    {
        university.name = nameTF.text!
        university.location = locationTF.text!
        university.numberOfStudents = Int(numberOfStudentsTF.text!)!
        university.webpage = webpageTF.text!
        print ("Data saved.")
    }
    
    
    @IBAction func webpageButtonTapped(sender: UIButton)
    {
        let myURL = NSURL(string: university.webpage)
        let SVC = SFSafariViewController(URL: myURL!)
        SVC.delegate = self
        presentViewController(SVC, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController)
    {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}
