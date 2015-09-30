//
//  AppKitExtensions.swift
//  ArchiveWatch
//
//  Created by Hoon H. on 2015/09/30.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import AppKit

extension NSView {
	var center: CGPoint {
		get {
			return	frame.midPoint
		}
		set {
			frame	=	CGRect(x: newValue.x - frame.width/2, y: newValue.y - frame.height/2, width: frame.width, height: frame.height)
		}
	}
}