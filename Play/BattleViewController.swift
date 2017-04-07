//
//  BattleViewController.swift
//  Play
//
//  Created by admin on 07/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import SpriteKit

class BattleViewController: UIViewController {
    var pokemon : Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting the size of the scene that will appear
        let scene = BattleScene(size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view = SKView()
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        //passing the pokemon you get from view controller to battle scene
        scene.pokemon = pokemon
        scene.scaleMode = .aspectFit
        //giving battle scene the access or authority to load
        skView.presentScene(scene)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
