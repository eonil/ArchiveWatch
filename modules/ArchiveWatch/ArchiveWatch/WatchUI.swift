//
//  WatchUI.swift
//  ArchiveWatch
//
//  Created by Hoon H. on 2015/09/30.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import AppKit

class WatchUI {

	init() {
		_wincon.window!.appearance		=   NSAppearance(named: NSAppearanceNameVibrantDark)
		_wincon.window!.styleMask		|=	NSResizableWindowMask
		_wincon.window!.styleMask		|=	NSClosableWindowMask
		_wincon.window!.styleMask		|=	NSMiniaturizableWindowMask
		_wincon.window!.styleMask		|=	NSTitledWindowMask
		_wincon.window!.collectionBehavior	=	NSWindowCollectionBehavior.FullScreenPrimary
		_wincon.contentViewController		=	image.viewController
	}
	deinit {

	}

	///

	weak var model: WatchModel? {
		didSet {
			image.model	=	model
		}
	}

	///

	let	image	=	ImageWatchUI()

	///

	var windowController: NSWindowController {
		get {
			return	_wincon
		}
	}

	///

	private let	_wincon	=	NSWindowController(window: NSWindow())
	
}