//
//  ImageWatchUI.swift
//  ArchiveWatch
//
//  Created by Hoon H. on 2015/09/30.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import AppKit

class ImageWatchUI {

	init() {

	}
	deinit {

	}

	///

	weak var model: WatchModel? {
		willSet {
			if let model = model {
				model.channel.deregister(ObjectIdentifier(self))
			}
		}
		didSet {
			if let model = model {
				_processSelection()
				model.channel.register(ObjectIdentifier(self)) { [weak self] in self?._processSignal($0) }
			}
		}
	}

	///

	var data: String? {
		didSet {

		}
	}

	///

	var viewController: NSViewController {
		get {
			return	_vc
		}
	}

	///

	private let	_vc	=	_VC()

	private func _processSelection() {
		do {
			if let idx = model?.selectionIndex {
				let	name			=	model!.fileNames[idx]
				let	data			=	try model!.dataForName(name)
				_vc.nameLabel.stringValue	=	name
				_vc.imageView.image		=	NSImage(data: data)
			}
			else {
				_vc.nameLabel.stringValue	=	""
				_vc.imageView.image		=	nil
			}
		}
		catch let error as NSError {
			_vc.presentError(error)
			_vc.nameLabel.stringValue	=	""
			_vc.imageView.image		=	nil
		}

		_vc.view.needsLayout	=	true
	}
	private func _processSignal(s: WatchModel.Signal) {
		switch s {
		case .SelectionWillChange:
			break
		case .SelectionDidChange:
			_processSelection()
		}
	}

}

private class _VC: NSViewController {
	let	imageView	=	NSImageView()
	let	nameLabel	=	NSTextField()

	private override func loadView() {
		let	v	=	NSView(frame: NSRect(x: 0, y: 0, width: 800, height: 450))
		v.wantsLayer	=	true
		view		=	v
	}
	private override func viewDidLoad() {
		super.viewDidLoad()
		nameLabel.bordered	=	false
		nameLabel.editable	=	false
		view.addSubview(imageView)
//		view.addSubview(nameLabel)
	}

	private override func viewDidLayout() {
		super.viewDidLayout()
		imageView.frame		=	view.bounds
		nameLabel.sizeToFit()
		nameLabel.center	=	view.bounds.midPoint.pixelGridFittingPointForView(view)
	}

}







