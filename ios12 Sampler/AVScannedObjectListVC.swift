//
//  AVScannedObjectListVC.swift
//  ios12 Sampler
//
//  Created by Testing on 13/06/18.
//  Copyright © 2018 Testing. All rights reserved.
//

import UIKit

class AVScannedObjectListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    static let kArObject = "arobject"
    static let kPng = "png"
    var arrObjectName:[String] = []
    var arrObejectURL :[[String:URL]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllStoredObjectModelFromDirectory()
        // Do any additional setup after loading the view.
    }
    func getAllStoredObjectModelFromDirectory() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            let arobjectFiles = directoryContents.filter{ $0.pathExtension == AVScannedObjectListVC.kArObject || $0.pathExtension == AVScannedObjectListVC.kPng }
            print("arobject urls:",arobjectFiles)
            let fileName = arobjectFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("object Name list:", fileName)
            for itm in arobjectFiles {
                if "\(itm)".contains(AVScannedObjectListVC.kArObject){
                    print("contain ARobejct")
                    arrObejectURL.append([AVScannedObjectListVC.kArObject:itm])
                } else {
                    print("contain image")
                    arrObejectURL.append([AVScannedObjectListVC.kPng:itm])
                }
            }
            arrObjectName = fileName
            if arrObjectName.count == 0 {
                self.tableView.setBackgroundText(stringValue: "There is no Scanned/Saved objects available. \n Please Scan and Save Object from Scan New Object Section.")
                self.tableView.reloadData()
            } else {
                self.tableView.removeBackgroundText()
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
extension UITableView {
    
    func setBackgroundText(stringValue:String) {
        let backgroundLabel = UILabel()
        backgroundLabel.font = UIFont.systemFont(ofSize: 14)
        backgroundLabel.textColor = .black
        backgroundLabel.numberOfLines = 0
        
        backgroundLabel.textAlignment = .center
        backgroundLabel.text = stringValue
        
        backgroundLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundLabel.translatesAutoresizingMaskIntoConstraints = true
        
        self.backgroundView = backgroundLabel
    }
    
    func removeBackgroundText() {
        self.backgroundView = nil
    }
}
