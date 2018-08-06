//
//  SettingsScene.swift
//  PixlPong
//
//  Created by Juan Jose Elias Navaro on 03/03/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import SpriteKit
import GameplayKit

class SettingsScene: SKScene {
    
    // MARK: - Scenes -
    var startScene:SKScene!
    
    // MARK: - Nodes -
    var btnCancel:SKSpriteNode?
    var btnSave:SKSpriteNode?
    var lblCancel:SKLabelNode?
    var lblSave:SKLabelNode?
    weak var lblSound:SKLabelNode?
    weak var lblQuit:SKLabelNode?
    
    // MARK: - Methods -
    override func didMove(to view: SKView) {
        
        self.size = CGSize(width: screenWidth, height: screenHeight)
        
        btnCancel = self.childNode(withName: "btnCancel") as? SKSpriteNode
        btnSave = self.childNode(withName: "btnSave") as? SKSpriteNode
        lblCancel = btnCancel?.childNode(withName: "lblCancel") as? SKLabelNode
        lblSave = btnSave?.childNode(withName: "lblSave") as? SKLabelNode
        lblSound = self.childNode(withName: "lblSound") as? SKLabelNode
        lblQuit = self.childNode(withName: "lblQuit") as? SKLabelNode

        btnCancel?.color = .clear
        btnSave?.color = .clear
        
        lblSave?.fontName = "8BITWONDERNominal"
        lblCancel?.fontName = "8BITWONDERNominal"

        lblSound?.fontName = "8BITWONDERNominal"
        lblQuit?.fontName = "8BITWONDERNominal"
        
        lblCancel?.text = "cancel"
        lblSave?.text = "save"
        lblSound?.text = "sound: on"
        lblQuit?.text = "quit game"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == btnCancel || node == lblCancel || node == lblQuit{
                print("Cancel touched")
                returnToStart()
            }
            else if node == lblSound{
                print("lbl Sound selected, deactivate all sounds")
            }
            else if node == btnSave || node == lblSave {
                print("Save touched")
                // ToDo save settings
                returnToStart()
            }
        }
    }
    
    // MARK: - Functions -
    
    func returnToStart(){
        print("returnToStart")
        let transition = SKTransition.fade(withDuration: 1)
        startScene = SKScene(fileNamed: "StartScene")
        startScene.scaleMode = .aspectFill
        self.view?.presentScene(startScene, transition: transition)
    }
    
    func saveSettings(){
        
    }
}
