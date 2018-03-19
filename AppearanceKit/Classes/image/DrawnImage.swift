//
//  DrawnImage.swift
//  AppearanceKit
//
//  Created by Georges Boumis on 08/03/2018.
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
import UIKit
import ContentKit
import QuartzCore

final public class DrawnImage: ContentKit.Image {
    
    public typealias DrawBlock = (_ `self`: ContentKit.Image, _ bounds: CGRect, _ context: CGContext) -> Void
    
    public struct Options {
        public let size: ContentKit.Size
        public let drawBlock: DrawBlock
        
        public init(size: ContentKit.Size, drawBlock: @escaping DrawBlock) {
            self.size = size
            self.drawBlock = drawBlock
        }
    }
    
    final private let decorated: ContentKit.Image
    final private let options: Options
    
    public init(decorated: ContentKit.Image, options: Options) {
        self.decorated = decorated
        self.options = options
    }
    
    final private lazy var drawnImage: ContentKit.Image = {
        return autoreleasepool {
            
            let size  = self.options.size.asCGSize
            let rect  = CGRect(origin: CGPoint.zero, size: size)
            let draw  = self.options.drawBlock
            let scale = self.decorated.image.scale
            let image = self.decorated
            if #available(iOS 10.0,  *) {
                let renderer = UIGraphicsImageRenderer(size: size)
                let image = renderer.image(actions: { (context: UIGraphicsImageRendererContext) in
                    draw(image, rect, context.cgContext)
                })
                return AnyImage(image: image)
            }
            else {
                UIGraphicsBeginImageContextWithOptions(size, false, scale)
                defer { UIGraphicsEndImageContext() }
                guard let context = UIGraphicsGetCurrentContext() else { return self.decorated }
                draw(image, rect, context)
                guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return self.decorated }
                return AnyImage(image: result)
            }
        }
    }()
    
    public var image: UIImage {
        return self.drawnImage.image
    }
}
