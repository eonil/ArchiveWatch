//
//  Channel.swift
//  ArchiveWatch
//
//  Created by Hoon H. on 2015/09/30.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation

class Channel<T> {
	func register(identifier: ObjectIdentifier, handler: T->()) {
		_map[identifier]	=	handler
	}
	func deregister(identifier: ObjectIdentifier) {
		_map[identifier]	=	nil
	}

	///

	private var	_map	=	Dictionary<ObjectIdentifier, T->()>()
}
class CastableChannel<T>: Channel<T> {
	func cast(parameter: T) {
		for (_, v) in _map {
			v(parameter)
		}
	}
}