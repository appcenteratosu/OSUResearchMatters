//
//  ResearchComplianceViewController.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/8/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit

class ResearchComplianceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    223 Scott Hall
//    Research Compliance
//    405.744.1676
//    rdiana@okstate.edu
    @IBAction func openResearchCompliance(_ sender: Any) {
        let contact = Contact(name: "Research Compliance",
                              number: "405.744.1676",
                              email: "rdiana@okstate.edu",
                              location: "223 Scott Hall")
        showResearchGroup(contact: contact)
    }
    //
//    IACUC
//    405.744.3592
//    iacuc@okstate.edu
    @IBAction func openIACUC(_ sender: Any) {
        let contact = Contact(name: "Institutional Animal Care and Use Committee (IACUC)",
                              number: "405.744.3592",
                              email: "iacuc@okstate.edu",
                              location: "223 Scott Hall")
        showResearchGroup(contact: contact)
    }
    //
//    IRB
//    405.744.5700
//    irb@okstate.edu
    @IBAction func openIRB(_ sender: Any) {
        let contact = Contact(name: "Institutional Review Board",
                              number: "405.744.5700",
                              email: "irb@okstate.edu",
                              location: "223 Scott Hall")
        showResearchGroup(contact: contact)
    }
    //
//    Radiation and Laser Safety
//    405.744.7890
//    radsafe@okstate.edu
    @IBAction func openRLS(_ sender: Any) {
        let contact = Contact(name: "Radiation and Laser Safety",
                              number: "405.744.7890",
                              email: "radsafe@okstate.edu",
                              location: "223 Scott Hall")
        showResearchGroup(contact: contact)
    }
    //
//    Biological Safety
//    405.744.3203
//    ibc@okstate.edu
    @IBAction func openBS(_ sender: Any) {
        let contact = Contact(name: "Biological Safety",
                              number: "405.744.3203",
                              email: "ibc@okstate.edu",
                              location: "223 Scott Hall")
        showResearchGroup(contact: contact)
    }
    
    
    
    
    func showResearchGroup(contact: Contact) {
        performSegue(withIdentifier: "showResearchGroup", sender: contact)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResearchGroup" {
            if let vc = segue.destination as? ContactInfoViewController {
                if let contact = sender as? Contact {
                    vc.contact = contact
                }
            }
        }
    }

}
