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

    weak var titleNode:SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        self.size = CGSize(width: screenWidth, height: screenHeight)
        
        settingsNode = self.childNode(withName: "settingsNode") as? SKSpriteNode
        startLbael = self.childNode(withName: "startNode") as? SKLabelNode
        titleNode = self.childNode(withName: "titleNode") as? SKLabelNode

        startLbael?.fontName = GlobalData.shared.fontName
        titleNode?.fontName = GlobalData.shared.fontName
        
        configSettings()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == settingsNode {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
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
    
    func configSettings(){
        let upY:CGFloat = (screenHeight - settingsNode!.frame.height)/2 - 25
        let rightX:CGFloat = (screenWidth - settingsNode!.frame.width)/2 - 25
        
        settingsNode?.position = CGPoint(x: rightX, y: upY)
    }
}
