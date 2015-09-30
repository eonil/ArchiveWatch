//
//  Archive.swift
//  ArchiveWatch
//
//  Created by Hoon H. on 2015/09/30.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UnrarKit
import ObjectiveZip



protocol ArchiveType {
	func extractFileList() throws -> [String]
	func extractFileAtPath(path: String) throws -> NSData
}



final class RARArchive: ArchiveType {
	init(location: NSURL) throws {
		_arc	=	try URKArchive(URL: location)
	}
	func extractFileList() throws -> [String] {
		assert(_arc != nil)
		return	try _arc!.listFilenames()
	}
	func extractFileAtPath(path: String) throws -> NSData {
		assert(_arc != nil)
		var	error	:	NSError?
		let	data	=	_arc!.extractDataFromFile(path, progress: { (progress: CGFloat) -> Void in
			}, error: &error)

		if let error = error {
			throw	error
		}

		return	data
	}

	///

	private var	_arc	:	URKArchive?
}

final class ZIPArchive: ArchiveType {
	init(location: NSURL) throws {
		guard let path = location.path else {
			throw	NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil)
		}
		_arc	=	try OZZipFile(fileName: path, mode: OZZipFileMode.Unzip)
	}
	deinit {
		try! _arc!.close()
	}
	func extractFileList() throws -> [String] {
		assert(_arc != nil)
		func conv(f: OZFileInZipInfo) -> String {
			return	f.name
		}
		return	(try _arc!.listFileInZipInfos()).map({ $0 as! OZFileInZipInfo }).map(conv)
	}
	func extractFileAtPath(path: String) throws -> NSData {
		assert(_arc != nil)
		try _arc!.locateFileInZip(path)
		let	info	=	try _arc!.getCurrentFileInZipInfo()
		let	read	=	try _arc!.readCurrentFileInZip()
		let	buffer	=	NSMutableData(length: Int(info.length))!
		var	error	:	NSError?
		let	readLen	=	read.readDataWithBuffer(buffer, error: &error)
		guard readLen == UInt(info.length) else {
			throw	NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil)
		}
		return	buffer
	}

	///

	private var	_arc	:	OZZipFile?
}









