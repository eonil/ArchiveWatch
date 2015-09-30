//
//  ArchiveDocument.swift
//  ArchiveWatch
//
//  Created by Hoon H. on 2015/09/30.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Cocoa

class ArchiveDocument: NSDocument {

	override func makeWindowControllers() {
		super.makeWindowControllers()
		addWindowController(_watchUI.windowController)
	}

	override class func autosavesInPlace() -> Bool {
		return false
	}

	override var windowNibName: String? {
		return	nil
	}

	override func dataOfType(typeName: String) throws -> NSData {
		// Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
		// You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
		throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
	}

	override func readFromURL(url: NSURL, ofType typeName: String) throws {
		_watchModel	=	try WatchModel(location: url)
		_watchUI.model	=	_watchModel
	}

	///

	@objc
	func stepBackward(_: AnyObject) {
		_watchModel?.stepBackwardWhereApplicable()
	}
	@objc
	func stepForward(_: AnyObject) {
		_watchModel?.stepForwardWhereApplicable()
	}
	@objc
	func step(_: AnyObject) {
		_watchModel?.stepForwardWhereApplicable()
	}

	///

	private var	_watchModel	:	WatchModel?
	private let	_watchUI	=	WatchUI()
}

