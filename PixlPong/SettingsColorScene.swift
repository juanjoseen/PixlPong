//
//  SettingsColorScene.swift
//  PixlPong
//
//  Created by Juan Jose Elias Navaro on 29/08/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import SpriteKit
import GameplayKit

class SettingsColorScene: SKScene {
    
    weak var lblBallColor:SKLabelNode!
    weak var lblBarColor:SKLabelNode!
    weak var btnBack:SKLabelNode!
    
    weak var selectedNodeBar:SKSpriteNode!
    weak var selectedNodeBall:SKSpriteNode!
    
    let settingsScene:SKScene! = SKScene(fileNamed: "SettingsScene")
    
    let BAR_TAG:Int = 4000
    let BALL_TAG:Int = 5000
    
    let colorList:[String] = ["#ffffff", "#607d8b", "#9e9e9e", "#795548", "#ff9800", "#ffeb3b", "#4caf50", "#00bcd4", "#2196f3", "#f44336"]
    
    var actionAppear:SKAction    = SKAction.fadeAlpha(by: 1, duration: 0.1)
    var actionDisappear:SKAction = SKAction.fadeAlpha(by: 0, duration: 0.1)
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: screenWidth, height: screenHeight)
        
        selectedNodeBar  = self.childNode(withName: "selectedNodeBar")  as! SKSpriteNode
        selectedNodeBall = self.childNode(withName: "selectedNodeBall") as! SKSpriteNode
        
        selectedNodeBar.alpha  = 0
        selectedNodeBall.alpha = 0
        
        configLabels()
        configColors()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == btnBack {
                backToSettings()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } else {
                if let data = node.userData {
                    if let item:String = data["nodeItem"] as? String {
                        
                        let sequence:SKAction = SKAction.sequence([actionAppear,actionDisappear, actionAppear, actionDisappear, actionAppear])
                        
                        if item == "ball" {
                            GlobalData.shared.useBallTextures = false
                            GlobalData.shared.ballColor = data["nodeColor"] as? String ?? ""
                            selectedNodeBall.position = node.position
                            selectedNodeBall.run(sequence)
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        } else if item == "bar" {
                            GlobalData.shared.useBarTextures = false
                            GlobalData.shared.barColor = data["nodeColor"] as? String ?? ""
                            selectedNodeBar.position = node.position
                            selectedNodeBar.run(sequence)
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    func backToSettings(){
        let transition = SKTransition.fade(withDuration: 1)
        settingsScene.scaleMode = .aspectFill
        self.view?.presentScene(settingsScene, transition: transition)
    }
    
    func configLabels(){
        lblBarColor  = self.childNode(withName: "lblBarColor")  as? SKLabelNode
        lblBallColor = self.childNode(withName: "lblBallColor") as? SKLabelNode
        btnBack      = self.childNode(withName: "btnBack") as? SKLabelNode
        
        lblBallColor.fontName = GlobalData.shared.fontName
        lblBarColor.fontName  = GlobalData.shared.fontName
        btnBack.fontName      = GlobalData.shared.fontName
        
        let leftX:CGFloat = 0 - screenWidth/2 + 25
        
        lblBarColor.position  = CGPoint(x: leftX + lblBarColor.frame.width/2, y: lblBarColor.position.y)
        lblBallColor.position = CGPoint(x: leftX + lblBallColor.frame.width/2, y: lblBallColor.position.y)
        
        let rightX:CGFloat = (screenWidth - btnBack.frame.width - 30)/2
        let downY:CGFloat = 0 - screenHeight/2 + 25
        
        btnBack.position = CGPoint(x: rightX, y: downY)
        
    }
    
    func configColors() {
        let ballColor:SKNode! = self.childNode(withName: "firstBallColor")
        let leftX:CGFloat = 0 - screenWidth/2 + 25
        ballColor.position = CGPoint(x: leftX, y: ballColor.position.y)
        ballColor.isHidden = true
        
        for i in 0..<colorList.count {
            let color:UIColor = UIColor.hexColor(colorList[i])
            let node:SKSpriteNode = SKSpriteNode(color: color, size: ballColor.frame.size)
            node.userData = [
                "nodeItem":"ball",
                "nodeColor":colorList[i]
            ]
            
            let firstP:CGPoint = ballColor.position
            let newX:CGFloat = firstP.x + (ballColor.frame.size.width + 10.0) * CGFloat(i)
            let position:CGPoint = CGPoint(x: newX, y: firstP.y)
            node.position = position
            
            self.addChild(node)
        }
        
        let barColor:SKNode! = self.childNode(withName: "firstBarColor")
        barColor.position = CGPoint(x: leftX, y: barColor.position.y)
        barColor.isHidden = true
        
        for i in 0..<colorList.count {
            let color:UIColor = UIColor.hexColor(colorList[i])
            let node:SKSpriteNode = SKSpriteNode(color: color, size: barColor.frame.size)
            node.userData = [
                "nodeItem":"bar",
                "nodeColor":colorList[i]
            ]
            
            let firstP:CGPoint = barColor.position
            let newX:CGFloat = firstP.x + (barColor.frame.size.width + 10.0) * CGFloat(i)
            let position:CGPoint = CGPoint(x: newX, y: firstP.y)
            node.position = position
            
            self.addChild(node)
        }
        
    }

}
