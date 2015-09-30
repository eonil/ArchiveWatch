//
//  CoreGraphicsExtensions.swift
//  ArchiveWatch
//
//  Created by Hoon H. on 2015/09/30.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import CoreGraphics
import AppKit

extension CGRect {
	var midPoint: CGPoint {
		get {
			return	CGPoint(x: midX, y: midY)
		}
	}
}

extension CGPoint {
	func pixelGridFittingPointForView(view: NSView) -> CGPoint {
		let	x1	=	round(x / 2) * 2
		let	y1	=	round(y / 2) * 2
		let	p1	=	CGPoint(x: x1, y: y1)
		return	p1

//		if let window = view.window? {
//			window.backingScaleFactor
//		}
//		else {
//
//		}
//		view.window!.screen
	}
}