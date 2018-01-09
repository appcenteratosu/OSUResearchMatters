//
//  ContactInfoViewController.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/7/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit
import MessageUI

class ContactInfoViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup
    func setupUI() {
//        headerImage.layer.cornerRadius = headerImage.frame.size.height / 2
//        headerImage.layer.borderColor = UIColor.lightGray.cgColor
//        headerImage.layer.borderWidth = 2
//        headerImage.clipsToBounds = true
        
        headerLabel.text = contact.name
        phoneNumberLabel.text = contact.number
        emailAddressLabel.text = contact.email
        locationLabel.text = contact.location
        
        headerLabel.numberOfLines = 2
        
        phoneCaptionLabel.text = "Front Desk"
        emailCaptionLabel.text = "\(contact.name) Office"
        emailCaptionLabel.numberOfLines = 0
        
        phoneView.layer.cornerRadius = 5
        emailVIew.layer.cornerRadius = 5
    }
    
    //MARK: - Outlets
    var contact: Contact!
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var phoneCaptionLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var emailCaptionLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    
    // MARK: - View Outlets
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var emailVIew: UIView!
    
    
    
    // MARK: - Functions
    @IBAction func callContact(_ sender: UIButton) {
        call(number: contact.number)
    }
    
    @IBAction func emailContact(_ sender: UIButton) {
        email(address: contact.email)
    }
    
    func email(address: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([address])
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func call(number: String) {
        guard let number = URL(string: "tel://\(number)") else {
            return
        }
        UIApplication.shared.open(number)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
