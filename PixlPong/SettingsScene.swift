//
//  SettingsScene.swift
//  PixlPong
//
//  Created by Juan Jose Elias Navaro on 03/03/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import GameKit
import SpriteKit
import GameplayKit

class SettingsScene: SKScene, GKGameCenterControllerDelegate {
    
    // MARK: - Scenes -
    var startScene:SKScene!
    weak var settingsSceneTexture:SKScene!
    
    // MARK: - Nodes -
    weak var lblSound:SKLabelNode?
    weak var lblQuit:SKLabelNode?
    weak var lblTextures:SKLabelNode?
    weak var lblLeader:SKLabelNode?
    
    // MARK: - Methods -
    override func didMove(to view: SKView) {
        
        self.size = CGSize(width: screenWidth, height: screenHeight)
        
        lblSound    = self.childNode(withName: "lblSound") as? SKLabelNode
        lblQuit     = self.childNode(withName: "lblQuit") as? SKLabelNode
        lblTextures = self.childNode(withName: "lblTextures") as? SKLabelNode
        lblLeader   = self.childNode(withName: "lblLeader") as? SKLabelNode
        
        lblSound?.fontName    = GlobalData.shared.fontName
        lblQuit?.fontName     = GlobalData.shared.fontName
        lblTextures?.fontName = GlobalData.shared.fontName
        lblLeader?.fontName   = GlobalData.shared.fontName
        
        lblSound?.text    = "Back"
        lblQuit?.text     = "Colors"
        lblTextures?.text = "textures"
        lblLeader?.text   = "Leaderboard"
        
        let rightX:CGFloat = (screenWidth - lblSound!.frame.width - 30)/2
        let downY:CGFloat = 0 - screenHeight/2 + 25
        
        lblSound?.position = CGPoint(x: rightX, y: downY)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == lblSound{
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                returnToStart()
            } else if node == lblTextures{
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                gotoTexturesScene()
            } else if node == lblQuit {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                goToColorScene()
            } else if node == lblLeader {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                openLeaderboard()
            }
        }
    }
    
    // MARK: - Functions -
    
    func returnToStart(){
        let transition = SKTransition.fade(withDuration: 1)
        startScene = SKScene(fileNamed: "StartScene")
        startScene.scaleMode = .aspectFill
        self.view?.presentScene(startScene, transition: transition)
    }
    
    func gotoTexturesScene(){
        let transition = SKTransition.fade(withDuration: 1)
        settingsSceneTexture = SKScene(fileNamed: "SettingsTexturesScene")
        settingsSceneTexture.scaleMode = .aspectFill
        self.view?.presentScene(settingsSceneTexture, transition: transition)
    }
    
    func goToColorScene(){
        let transition = SKTransition.fade(withDuration: 1)
        let colorScene:SKScene! = SKScene(fileNamed: "SettingsColorScene")
        colorScene.scaleMode = .aspectFill
        self.view?.presentScene(colorScene, transition: transition)
    }
    
    func openLeaderboard(){
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = GlobalData.shared.LEADERBOARD_ID
        self.view?.window?.rootViewController?.present(gcVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
