//
//  ViewController.swift
//  SCNKinnerSwift
//
//  Created by YN on 2018/4/16.
//  Copyright © 2018年 HYN. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var scnView: SCNView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Set the view's delegate
//        sceneView.delegate = self
//
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
        
       setUpGameView()
        
    }
    
    func setUpGameView() {
    
       //1.创建专用视图
        scnView = SCNView.init(frame: self.view.bounds)
        scnView.backgroundColor = UIColor.clear
        scnView.allowsCameraControl = true
        self.view.addSubview(scnView)
        
        //2.创建场景资源对象
        let path = Bundle.main.url(forResource: "skinning", withExtension: ".dae")
        let sceneSource = SCNSceneSource.init(url: path!, options: nil)
        
        //3.创建场景
        scnView.scene = sceneSource?.scene(options: nil)
        
         //4.获取场景中的某种对象的标识数组
        let animationIDs = sceneSource?.identifiersOfEntries(withClass: CAAnimation.self)
        var animationArr:[CAAnimation] = []
        
        for id in animationIDs! {
          
            let animation = sceneSource?.entryWithIdentifier(id, withClass: CAAnimation.self)
            
            animationArr.append(animation!)
        }
        
        
        //6.创建一个动画组
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = animationArr
        
        //7.截取我们要的动画阶段比如（20~24秒）
        animationGroup.duration = 24.33
        animationGroup.repeatCount = 1000
        animationGroup.beginTime = 0
  
        
         //8.将动画组添加到模型节点上
        let node = scnView.scene?.rootNode.childNode(withName: "node", recursively: true)
        node?.addAnimation(animationGroup, forKey: "animation")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
