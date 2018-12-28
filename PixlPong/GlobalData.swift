//
//  GlobalData.swift
//  PixlPong
//
//  Created by Juan Jose Elias Navaro on 09/08/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import UIKit

class GlobalData {
    
    static let shared:GlobalData = GlobalData()
    private let defaults:UserDefaults = UserDefaults.standard
    
    private init(){
    }
    
    var LEADERBOARD_ID:String {
        get {
            return "global_pixlpong_leaderboard"
        }
    }
    
    // MARK: - Score -
    var maxScore:Double {
        get {
            return defaults.double(forKey: "com.PixlPong.data.maxScore")
        }
        set (newValue) {
            if maxScore < newValue {
                defaults.set(newValue, forKey: "com.PixlPong.data.maxScore")
            }
        }
    }
    
    var localScore:Double = 0
    
    // MARK: - Ball color & textures -
    var ballColor:String {
        get {
            return defaults.string(forKey: "com.PixlPong.data.ballColor") ?? "#FFFFFF"
        }
        set (newValue) {
            defaults.set(newValue, forKey: "com.PixlPong.data.ballColor")
        }
    }
    
    var useBallTextures:Bool {
        get {
            return defaults.bool(forKey: "com.PixlPong.data.useBallTextures")
        }
        set (newValue) {
            defaults.set(newValue, forKey: "com.PixlPong.data.useBallTextures")
        }
    }
    
    var ballTexture:String {
        get {
            return defaults.string(forKey: "com.PixlPong.data.ballTexture") ?? ""
        }
        set (newValue) {
            defaults.set(newValue, forKey: "com.PixlPong.data.ballTexture")
        }
    }
    
    // MARK: - Bars color & textures -
    var barColor:String {
        get {
            let color:String = defaults.string(forKey: "com.PixlPong.data.barColor") ?? "#FFFFFF"
            return color
        }
        set (newValue) {
            defaults.set(newValue, forKey: "com.PixlPong.data.barColor")
        }
    }
    
    var useBarTextures:Bool {
        get {
            return defaults.bool(forKey: "com.PixlPong.data.useBarTextures")
        }
        set (newValue) {
            defaults.set(newValue, forKey: "com.PixlPong.data.useBarTextures")
        }
    }
    
    var barTexture:String {
        get {
            return defaults.string(forKey: "com.PixlPong.data.barTexture") ?? ""
        }
        set (newValue) {
            defaults.set(newValue, forKey: "com.PixlPong.data.barTexture")
        }
    }
    
    // MARK: - Fonts -
    var fontName:String {
        get {
            return "8BITWONDERNominal"
        }
    }
    
}
