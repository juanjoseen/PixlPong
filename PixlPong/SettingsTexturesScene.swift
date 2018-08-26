//
//  SettingsTexturesScene.swift
//  PixlPong
//
//  Created by Carlos Uribe on 13/08/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import SpriteKit
import GameplayKit

class SettingsTexturesScene: SKScene{
    var sknWoodTextureBar:SKSpriteNode?
    var sknRWoodTextureBar:SKSpriteNode?
    var sknBrushedMetalTextureBar:SKSpriteNode?
    var sknChessTextureBar:SKSpriteNode?
    var sknConcretTextureBar:SKSpriteNode?
    var sknVintageClayTextureBar:SKSpriteNode?
    var sknWoodTextureBall:SKSpriteNode?
    var sknAsphaltTextureBall:SKSpriteNode?
    var sknRWoodTextureBall:SKSpriteNode?
    var sknBrushedMetalTextureBall:SKSpriteNode?
    var sknChessTextureBall:SKSpriteNode?
    var sknConcretTextureBall:SKSpriteNode?
    var sknVintageClayTextureBall:SKSpriteNode?
    var actionAppear:SKAction = SKAction.fadeAlpha(by: 1, duration: 0.1)
    var actionDisappear:SKAction = SKAction.fadeAlpha(by: 0, duration: 0.1)

    weak var selectedNodeBar:SKSpriteNode?
    weak var selectedNodeBall:SKSpriteNode?
    weak var barTexture:SKLabelNode?
    weak var ballTexture:SKLabelNode?
    weak var backButton:SKLabelNode?
    weak var settingsScene:SKScene!

    override func didMove(to view: SKView) {
        self.size = CGSize(width: screenWidth, height: screenHeight)

        barTexture = self.childNode(withName: "barTexture") as? SKLabelNode
        ballTexture = self.childNode(withName: "barTexture") as? SKLabelNode
        backButton = self.childNode(withName: "backButton") as? SKLabelNode

        barTexture?.fontName = GlobalData.shared.fontName
        ballTexture?.fontName = GlobalData.shared.fontName
        backButton?.fontName = GlobalData.shared.fontName

        sknWoodTextureBar = self.childNode(withName: "sknWoodTexture") as? SKSpriteNode
        sknRWoodTextureBar = self.childNode(withName: "sknRWoodTexture") as? SKSpriteNode
        sknBrushedMetalTextureBar = self.childNode(withName: "sknBrushedMetalTexture") as? SKSpriteNode
        sknChessTextureBar = self.childNode(withName: "sknChessTexture") as? SKSpriteNode
        sknConcretTextureBar = self.childNode(withName: "sknConcretTexture") as? SKSpriteNode
        sknVintageClayTextureBar = self.childNode(withName: "sknVintageClayTexture") as? SKSpriteNode

        sknWoodTextureBall = self.childNode(withName: "sknWoodTexture") as? SKSpriteNode
        sknRWoodTextureBall = self.childNode(withName: "sknRWoodTexture") as? SKSpriteNode
        sknBrushedMetalTextureBall = self.childNode(withName: "sknBrushedMetalTexture") as? SKSpriteNode
        sknChessTextureBall = self.childNode(withName: "sknChessTexture") as? SKSpriteNode
        sknConcretTextureBall = self.childNode(withName: "sknConcretTexture") as? SKSpriteNode
        sknVintageClayTextureBall = self.childNode(withName: "sknVintageClayTexture") as? SKSpriteNode

        selectedNodeBar = self.childNode(withName: "selectedNodeBar") as? SKSpriteNode
        selectedNodeBar?.alpha = 0.0
        selectedNodeBall = self.childNode(withName: "selectedNodeBall") as? SKSpriteNode
        selectedNodeBall?.alpha = 0.0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            let secuence:SKAction = SKAction.sequence([actionAppear,actionDisappear, actionAppear, actionDisappear, actionAppear])

            if let tmpNode:SKSpriteNode = node as? SKSpriteNode{
                if (tmpNode.name?.lowercased().contains("bar"))!{
                    GlobalData.shared.barTexture = (tmpNode.name)!
                    GlobalData.shared.useBarTextures = true
                    selectedNodeBar?.position = tmpNode.position
                    selectedNodeBar?.run(secuence)
                }
                else{
                    GlobalData.shared.ballTexture = (tmpNode.name)!
                    GlobalData.shared.useBallTextures = true
                    selectedNodeBall?.position = tmpNode.position
                    selectedNodeBall?.run(secuence)
                }
            }
            else{
                switch node.name{
                case backButton?.name:
                    returnToStart()
                    break

                default:break
                }
            }
        }
    }

    func returnToStart(){
        print("returnToSettings")
        let transition = SKTransition.fade(withDuration: 1)
        settingsScene = SKScene(fileNamed: "SettingsScene")
        settingsScene.scaleMode = .aspectFill
        self.view?.presentScene(settingsScene, transition: transition)
    }
}
