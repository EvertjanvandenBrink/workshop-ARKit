//
//  ViewController.swift
//  ARKit Workshop
//
//  Created by Niels on 11/03/19.
//  Copyright © 2019 Arkit Workshop. All rights reserved.
//


import UIKit
import SceneKit
import ARKit

class AVImageDetaction: UIViewController, ARSCNViewDelegate,ARSKViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var viewObj = UIImageView()

    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
    }
   
   //  Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        return nil
    }
}
