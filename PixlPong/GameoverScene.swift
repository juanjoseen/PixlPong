//
//  GameoverScene.swift
//  PixlPong
//
//  Created by Juan Jose Elias Navaro on 29/07/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameoverScene: SKScene {

    var lblGameover:SKLabelNode?
    var lblMaxScore:SKLabelNode?
    var lblScore:SKLabelNode?
    
    var homeNode:SKLabelNode?
    var retryNode:SKLabelNode?
    
    var startScene:SKScene!
    var gameScene:SKScene!
    
    override func didMove(to view: SKView) {
        
        self.size = CGSize(width: screenWidth, height: screenHeight)
        
        lblGameover = self.childNode(withName: "lblGameover") as? SKLabelNode
        lblMaxScore = self.childNode(withName: "lblMaxScore") as? SKLabelNode
        lblScore    = self.childNode(withName: "lblScore") as? SKLabelNode
        
        homeNode  = self.childNode(withName: "btnHome") as? SKLabelNode
        retryNode = self.childNode(withName: "btnRetry") as? SKLabelNode
        
        lblGameover?.fontName = GlobalData.shared.fontName
        lblMaxScore?.fontName = GlobalData.shared.fontName
        lblScore?.fontName    = GlobalData.shared.fontName
        
        homeNode?.fontName  = GlobalData.shared.fontName
        retryNode?.fontName = GlobalData.shared.fontName
        
        
        startScene = SKScene(fileNamed: "StartScene")
        startScene.scaleMode = .aspectFill
        
        gameScene = SKScene(fileNamed: "GameScene")
        gameScene.scaleMode = .aspectFill
        
        lblScore?.text    = "Score: \(Int(GlobalData.shared.localScore))"
        lblMaxScore?.text = "Max Score: \(Int(GlobalData.shared.maxScore))"
        
        let gameoverSound:SKAction = SKAction.playSoundFileNamed("fail.m4a", waitForCompletion: false)
        play(sound: gameoverSound)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == homeNode {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                let transition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(startScene, transition: transition)
            } else if node == retryNode {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                let transition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
