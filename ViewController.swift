//
//  ViewController.swift
//  CollegeProfileBuilder
//
//  Created by pazar on 1/25/16.
//  Copyright © 2016 Patrick Azar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    var colleges : [College] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        colleges.append(College(Name: "Beloit College", Location: "Beloit, WI", NumberOfStudents: 1261, Image: UIImage(named: "beloit")!, Webpage: "https://www.beloit.edu/"))
        colleges.append(College(Name: "Centre College", Location: "Danville, KY", NumberOfStudents: 1343, Image: UIImage(named: "centre")!, Webpage: "https://www.centre.edu/"))
        colleges.append(College(Name: "Knox College", Location: "Galesburg, IL", NumberOfStudents: 1392, Image: UIImage(named: "knox")!, Webpage: "https://www.knox.edu/"))
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = myTableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        myCell.textLabel!.text = colleges[indexPath.row].name
        myCell.detailTextLabel!.text = colleges[indexPath.row].location
        return myCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return colleges.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            colleges.removeAtIndex(indexPath.row)
            myTableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let detailView = segue.destinationViewController as! DetailedViewController
        let selectedRow = myTableView.indexPathForSelectedRow!.row
        detailView.university = colleges[selectedRow]
        
    }
    @IBAction func addButtonTapped(sender: UIBarButtonItem)
    {
        let myAlert = UIAlertController(title: "Add College", message: nil, preferredStyle: .Alert)
        myAlert.addTextFieldWithConfigurationHandler{(nameTextfield) -> Void in
            nameTextfield.placeholder = "Add College Name"
        }
        myAlert.addTextFieldWithConfigurationHandler{(locationTextfield) -> Void in
            locationTextfield.placeholder = "Add College Location"
        }
        myAlert.addTextFieldWithConfigurationHandler{(numberOfStudentsTextfield) -> Void in
            numberOfStudentsTextfield.placeholder = "Add Number of Students"
        }
        myAlert.addTextFieldWithConfigurationHandler
            {(webpageTextfield) -> Void in
            webpageTextfield.placeholder = "Add Homepage URL"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        myAlert.addAction(cancelAction)
        let addAction = UIAlertAction(title: "Add", style: .Default) { (addAction) -> Void in
            let collegeTF = myAlert.textFields![0] as UITextField
            let locationTF = myAlert.textFields![1] as UITextField
            let numberOfStudentsTF = myAlert.textFields![2] as UITextField
            let webpageTF = myAlert.textFields![3] as UITextField
            self.colleges.append(College(Name: collegeTF.text!, Location: locationTF.text!, NumberOfStudents: Int(numberOfStudentsTF.text!)!, Webpage: webpageTF.text!))
            self.myTableView.reloadData()
        }
        myAlert.addAction(addAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        myTableView.reloadData()
    }
    @IBAction func editButtonTapped(sender: UIBarButtonItem)
    {
        if editButton.tag == 0
        {
            myTableView.editing = true
            editButton.tag = 1
        }
        else
        {
            myTableView.editing = false
            editButton.tag = 0
        }
    }
    
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let universities = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(universities, atIndex: destinationIndexPath.row)
    }
    
}

