//
//  RandomColor.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 15/05/2017.
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//
//

import Foundation

public struct RandomColor: Color {
    public let color: UIColor
    public init() {
        self.color = UIColor(colorLiteralRed: Float(arc4random_uniform(UInt32(255)))/255.0,
                               green: Float(arc4random_uniform(UInt32(255)))/255.0,
                               blue: Float(arc4random_uniform(UInt32(255)))/255.0,
                               alpha: 0.75)
    }
}

extension RandomColor: CustomPlaygroundQuickLookable {
    
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.color(self.color)
    }
    
    public func debugQuickLookObject() -> AnyObject? {
        return self.color
    }
}
