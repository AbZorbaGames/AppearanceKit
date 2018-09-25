//
//  TextColor.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 25/07/2016.
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

public struct TextColor: Color {
    public var normal: Color
    public var highlighted: Color? = nil
    public var disabled: Color? = nil
    public var selected: Color? = nil
    
    public init(normal: Color,
                highlighted: Color? = nil,
                selected: Color? = nil,
                disabled: Color? = nil) {
        self.normal = normal
        self.highlighted = highlighted
        self.selected = selected
        self.disabled = disabled
    }
}

public extension TextColor {
    
    public var color: UIColor {
        return self.normal.color
    }
}

public extension TextColor {
    
    public func configure(button: UIButton,
                          forStates states: [UIControl.State]) {
        states.forEach { state in
            button.setTitleColor(self.color(fromState: state)?.color,
                                 for: state)
        }
    }
    
    public func color(fromState state: UIControl.State) -> Color? {
        switch state {
        case UIControl.State.disabled:
            return self.disabled
        case UIControl.State.normal:
            return self
        case UIControl.State.highlighted:
            return self.highlighted
        case UIControl.State.selected:
            return self.selected
        default:
            return self.normal
        }
    }
}

