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
        print("welcome to Pokeworld")
        print(pokemon.name)
    }
    
}
