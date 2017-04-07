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
    var pokemonSprite : SKSpriteNode!
    var pokeballSprite: SKSpriteNode!
    //define constants 
    let kPokemonSize = CGSize(width: 100, height: 100)
    let kPokeballSize = CGSize(width: 50, height: 50)
    
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
        //calling pokemon and pokeball functions
        self.perform(#selector(setupPokemon), with: nil, afterDelay: 2.0)
        self.perform(#selector(setupPokeball), with: nil, afterDelay: 2.0)
        
    }
    func setupPokemon(){
        self.pokemonSprite = SKSpriteNode(imageNamed: pokemon.imageFileName!)
        self.pokemonSprite.size = kPokemonSize
        self.pokemonSprite.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.pokemonSprite.zPosition = 1
        //defining the movements of pokemon
        let moveRight = SKAction.moveBy(x: 100, y: 0, duration: 3.0)
        let sequence = SKAction.sequence([moveRight, moveRight.reversed(), moveRight.reversed(), moveRight])
       self.pokemonSprite.run(SKAction.repeatForever(sequence))
        self.addChild(pokemonSprite)
    }
    func setupPokeball(){
        self.pokeballSprite = SKSpriteNode(imageNamed: "pokeball")
        self.pokeballSprite.size = kPokeballSize
        self.pokeballSprite.position = CGPoint(x: self.size.width/2, y: 50)
        self.pokeballSprite.zPosition = 1
        self.addChild(pokeballSprite)
        
    }
    
}
