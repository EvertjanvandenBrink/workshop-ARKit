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
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create gif & Add to viewobject
        let giphy: UIImage? = UIImage.gifImageWithName("giphy")
        let imageView = UIImageView(image: giphy)
        viewObj = imageView
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        let dumbleDore = ARReferenceImage(UIImage(named: "johan")!.cgImage!,
                                       orientation: CGImagePropertyOrientation.up,
                                       physicalWidth: 0.90)
       
        configuration.trackingImages = [dumbleDore]
        configuration.maximumNumberOfTrackedImages = 1
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
   
   //  Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.8)
          
            let material = SCNMaterial()
            material.diffuse.contents = viewObj
            plane.materials = [material]
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
        }
        return node
    }
}
