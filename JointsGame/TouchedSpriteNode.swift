//
//  TouchedSpriteNode.swift
//  JointsGame
//
//  Created by Ilya B Macmini on 04/04/2020.
//  Copyright © 2020 ilyabiltuev. All rights reserved.
//

import Foundation
import SpriteKit

class TouchedSpriteNode: SKSpriteNode {
    
    var wasDynamic = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        self.wasDynamic = self.physicsBody?.isDynamic ?? false
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        guard let touch = touches.first, let scene = self.scene else { return }
    
        let location = touch.location(in: scene)
        
        // Restore dynamic state and then set the new position
        self.physicsBody?.isDynamic = self.wasDynamic;
        self.position = location;
        
        // Wait a small amount of time before turning off dynamic to update the physics on the object,
        // which will do a soft pause in physics calculations
        run(SKAction.wait(forDuration: 0.01)) {
            
            self.physicsBody?.isDynamic = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Restore dynamic state to allow physics to behave as normal ie unpause
        self.physicsBody?.isDynamic = self.wasDynamic;
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Restore dynamic state to allow physics to behave as normal ie unpause
        self.physicsBody?.isDynamic = self.wasDynamic;
    }
}
