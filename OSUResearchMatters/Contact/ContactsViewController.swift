//
//  ContactsViewController.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/7/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Outlets
    
    @IBAction func openVPR(_ sender: Any) {
        let vpr = Contact(name: "VPR",
                          number: "405.744.1676",
                          email: "rdiana@okstate.edu",
                          location: "203 Whitehurst")
        openSelectedContact(contact: vpr)
    }
    
    @IBAction func openResearchServices(sender: Any) {
        let RS = Contact(name: "Research Services",
                               number: "405.744.9991",
                               email: "research@okstate.edu",
                               location: "206 Whitehurst")
        openSelectedContact(contact: RS)
    }
    
    @IBAction func openAnimalResources(sender: Any) {
        let AR = Contact(name: "Animal Resources",
                               number: "405.744.7631",
                               email: "Research.animals@okstate.edu",
                               location: "101 McElroy Hall Annex")
        openSelectedContact(contact: AR)
    }
    
    @IBAction func openHPCC(sender: Any) {
        let HPCC = Contact(name: "HPCC",
                               number: "405.744.1695",
                               email: "hpcc@okstate.edu",
                               location: "106 Math Science")
        openSelectedContact(contact: HPCC)
    }
    
    @IBAction func openEPSCOR(sender: Any) {
        let EPCS = Contact(name: "EPSCoR",
                               number: "405.744.9964",
                               email: "vphillips@okepscor.org",
                               location: "415 Whitehurst")
        openSelectedContact(contact: EPCS)
    }
    
    @IBAction func openProposalDevelopment(sender: Any) {
        let PD = Contact(name: "Proposal Development",
                               number: "405.744.3660",
                               email: "Nani.pybus@okstate.edu",
                               location: "120SC HBRC")
        openSelectedContact(contact: PD)
    }
    
    @IBAction func openTDC(sender: Any) {
        let TDC = Contact(name: "Technology Development Center",
                               number: "405.744.6930",
                               email: "tdc@okstate.edu",
                               location: "1201 S. Innovation Way")
        openSelectedContact(contact: TDC)
    }
    
    @IBAction func openMicroscpreLab(sender: Any) {
        let ML = Contact(name: "Microscope Laboratory",
                               number: "405.744.6765",
                               email: "microscopy@okstate.edu",
                               location: "1110 S. Innovation Way")
        openSelectedContact(contact: ML)
    }
    
    
    // MARK:  - Functionality
    func openSelectedContact(contact: Contact) {
        performSegue(withIdentifier: "showContactInfo", sender: contact)
    }
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContactInfo" {
            if let vc = segue.destination as? ContactInfoViewController {
                if let contact = sender as? Contact {
                    vc.contact = contact
                }
            }
        }
    }

}
