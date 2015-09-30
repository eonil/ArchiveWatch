//
//  WatchModel.swift
//  ArchiveWatch
//
//  Created by Hoon H. on 2015/09/30.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation

class WatchModel {

	enum Signal {
		case SelectionWillChange
		case SelectionDidChange
	}

	///

	convenience init(location: NSURL) throws {
		guard let ext = location.pathExtension else {
			throw	NSError(domain: NSCocoaErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
		}
		switch ext.lowercaseString {
		case "rar":
			self.init(archive: try RARArchive(location: location))
		case "zip":
			self.init(archive: try ZIPArchive(location: location))
		default:
			throw	NSError(domain: NSCocoaErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
		}
	}
	init(archive: ArchiveType) {
		_archive	=	archive
		_filesCache	=	try! _archive.extractFileList()

		if numberOfFiles > 0 {
			selectionIndex	=	0
		}
	}

	///

	var numberOfFiles: Int {
		get {
			return	_filesCache.count
		}
	}
	var fileNames: [String] {
		get {
			return	_filesCache
		}
	}
	func dataForName(name: String) throws -> NSData {
		return	try _archive.extractFileAtPath(name)
	}
	var selectionIndex: Int? {
		willSet {
			_chan.cast(.SelectionWillChange)
		}
		didSet {
			_chan.cast(.SelectionDidChange)
		}
	}

	func stepBackwardWhereApplicable() {
		if selectionIndex > 0 {
			selectionIndex!--
		}
	}
	func stepForwardWhereApplicable() {
		if selectionIndex < (numberOfFiles - 1) {
			selectionIndex!++
		}
	}

	///

	var channel: Channel<Signal> {
		get {
			return	_chan
		}
	}

	///

	private let	_archive	:	ArchiveType
	private let	_filesCache	:	[String]
	private let	_chan		=	CastableChannel<Signal>()
}

