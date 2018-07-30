//
//  StartScene.swift
//  PixlPong
//
//  Created by Juan Jose Elias Navaro on 03/03/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var gameScene:SKScene!
    var settingsScene:SKScene!
    
    var settingsNode:SKSpriteNode?
    var startLbael:SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        self.size = CGSize(width: screenWidth, height: screenHeight)
        
        settingsNode = self.childNode(withName: "settingsNode") as? SKSpriteNode
        startLbael = self.childNode(withName: "startNode") as? SKLabelNode
        startLbael?.fontName = "ChalkboardSE-Regular"
        
//        print("Fonts....")
//        for family in UIFont.familyNames.sorted() {
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//            }
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == settingsNode {
                let transition = SKTransition.fade(withDuration: 1)
                settingsScene = SKScene(fileNamed: "SettingsScene")
                settingsScene.scaleMode = .aspectFill
                self.view?.presentScene(settingsScene, transition: transition)
            } else {
                let transition = SKTransition.fade(withDuration: 1)
                gameScene = SKScene(fileNamed: "GameScene")
                gameScene.scaleMode = .aspectFill
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
