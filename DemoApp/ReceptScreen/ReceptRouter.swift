//
//  ReceptRouter.swift
//  
// VIPER architecture used

import UIKit

protocol IReceptRouter: class {
	// do someting...
}

class ReceptRouter: IReceptRouter {	
	weak var view: ReceptViewController?
	
	init(view: ReceptViewController?) {
		self.view = view
	}
}
