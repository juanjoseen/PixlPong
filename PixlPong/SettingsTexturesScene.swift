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
    var sknHypTextureBall:SKSpriteNode?
    var sknChessTextureBall:SKSpriteNode?
    var actionAppear:SKAction = SKAction.fadeAlpha(by: 1, duration: 0.1)
    var actionDisappear:SKAction = SKAction.fadeAlpha(by: 0, duration: 0.1)

    weak var selectedNodeBar:SKSpriteNode?
    weak var selectedNodeBall:SKSpriteNode?
    weak var barTexture:SKLabelNode?
    weak var ballTexture:SKLabelNode?
    weak var backButton:SKLabelNode?
    let settingsScene:SKScene! = SKScene(fileNamed: "SettingsScene")

    override func didMove(to view: SKView) {
        self.size = CGSize(width: screenWidth, height: screenHeight)
        
        configLabels()
        configTextures()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            let secuence:SKAction = SKAction.sequence([actionAppear, actionDisappear, actionAppear, actionDisappear, actionAppear])

            if let tmpNode:SKSpriteNode = node as? SKSpriteNode{
                if (tmpNode.name?.lowercased().contains("bar"))!{
                    GlobalData.shared.barTexture = (tmpNode.name)!
                    GlobalData.shared.useBarTextures = true
                    selectedNodeBar?.position = tmpNode.position
                    selectedNodeBar?.run(secuence)
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                } else {
                    GlobalData.shared.ballTexture = (tmpNode.name)!
                    GlobalData.shared.useBallTextures = true
                    selectedNodeBall?.position = tmpNode.position
                    selectedNodeBall?.run(secuence)
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            } else {
                switch node.name{
                case backButton?.name:
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    returnToStart()
                    break

                default:break
                }
            }
        }
    }

    func returnToStart(){
        let transition = SKTransition.fade(withDuration: 1)
        settingsScene.scaleMode = .aspectFill
        self.view?.presentScene(settingsScene, transition: transition)
    }
    
    private func configLabels() {
        barTexture  = self.childNode(withName: "barTexture") as? SKLabelNode
        ballTexture = self.childNode(withName: "ballTexture") as? SKLabelNode
        backButton  = self.childNode(withName: "backButton") as? SKLabelNode
        
        barTexture?.fontName  = GlobalData.shared.fontName
        ballTexture?.fontName = GlobalData.shared.fontName
        backButton?.fontName  = GlobalData.shared.fontName
        
        let rightX:CGFloat = (screenWidth - backButton!.frame.width - 30)/2
        let downY:CGFloat = 0 - screenHeight/2 + 25
        
        let leftX:CGFloat = 0 - screenWidth/2 + ((barTexture?.frame.width)! + 50) / 2
        let upY:CGFloat = (screenHeight - (barTexture?.frame.height)! - 60)/2
        
        let leftX2:CGFloat = 0 - screenWidth/2 + ((ballTexture?.frame.width)! + 50) / 2
        let upY2:CGFloat = -(ballTexture?.frame.height)!
        
        barTexture?.position = CGPoint(x: leftX, y: upY)
        ballTexture?.position = CGPoint(x: leftX2, y: upY2)
        
        backButton?.position = CGPoint(x: rightX, y: downY)
    }
    
    private func configTextures() {
        sknWoodTextureBar         = self.childNode(withName: "sknWoodTextureBar")         as? SKSpriteNode
        sknRWoodTextureBar        = self.childNode(withName: "sknRWoodTextureBar")        as? SKSpriteNode
        sknBrushedMetalTextureBar = self.childNode(withName: "sknBrushedMetalTextureBar") as? SKSpriteNode
        sknChessTextureBar        = self.childNode(withName: "sknChessTextureBar")        as? SKSpriteNode
        sknConcretTextureBar      = self.childNode(withName: "sknConcretTextureBar")      as? SKSpriteNode
        sknVintageClayTextureBar  = self.childNode(withName: "sknVintageClayTextureBar")  as? SKSpriteNode
        
        sknHypTextureBall   = self.childNode(withName: "sknHypTextureBall")   as? SKSpriteNode
        sknChessTextureBall = self.childNode(withName: "sknChessTextureBall") as? SKSpriteNode
        
        sknHypTextureBall?.texture   = SKTexture(image: UIImage(named: "sknHypTextureBall")!.circleMasked!)
        sknChessTextureBall?.texture = SKTexture(image: UIImage(named: "sknChessTextureBall")!.circleMasked!)
        
        selectedNodeBar = self.childNode(withName: "selectedNodeBar") as? SKSpriteNode
        selectedNodeBar?.alpha = 0.0
        selectedNodeBall = self.childNode(withName: "selectedNodeBall") as? SKSpriteNode
        selectedNodeBall?.alpha = 0.0
        
        let leftX:CGFloat = (-screenWidth + (sknWoodTextureBar?.frame.width)! + 80)/2
        var upY:CGFloat = (screenHeight - (sknWoodTextureBar?.frame.height)! - 120) / 2
        
        sknWoodTextureBar?.position = CGPoint(x: leftX, y: upY)
        sknRWoodTextureBar?.position = CGPoint(x: (sknWoodTextureBar?.position.x)! + 60, y: (sknWoodTextureBar?.position.y)!)
        sknBrushedMetalTextureBar?.position = CGPoint(x: (sknRWoodTextureBar?.position.x)! + 60, y: (sknRWoodTextureBar?.position.y)!)
        sknChessTextureBar?.position = CGPoint(x: (sknBrushedMetalTextureBar?.position.x)! + 60, y: (sknBrushedMetalTextureBar?.position.y)!)
        sknConcretTextureBar?.position = CGPoint(x: (sknWoodTextureBar?.position.x)!, y: (sknWoodTextureBar?.position.y)! - 60)
        sknVintageClayTextureBar?.position = CGPoint(x: (sknConcretTextureBar?.position.x)! + 60, y: (sknConcretTextureBar?.position.y)!)
        
        
        upY = (ballTexture?.position.y)! - 40
        
        sknHypTextureBall?.position = CGPoint(x: leftX, y: upY)
        sknChessTextureBall?.position = CGPoint(x: (sknHypTextureBall?.position.x)! + 60, y: (sknHypTextureBall?.position.y)!)
    }
}
