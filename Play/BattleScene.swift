//
//  BattleScene.swift
//  Play
//
//  Created by admin on 07/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import SpriteKit

class BattleScene : SKScene, SKPhysicsContactDelegate {
    var pokemon : Pokemon!
    override func didMove(to view: SKView) {
        // print("welcome to Pokeworld")
        //print(pokemon.name)
        
        //this is the function like did load in view controller
        
        //Code for the background of battle scene
        let battleBg = SKSpriteNode(imageNamed: "bggg")
        battleBg.size = self.size
        battleBg.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        //anchor point is the point around which we design everything
        battleBg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        battleBg.zPosition = -1
        //adding this node to the scene
        self.addChild(battleBg)
        
    }
    
}
