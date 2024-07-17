//
//  Extensions.swift
//  Nanotes
//
//  Created by Gusti Rizky Fajar on 16/07/24.
//

import Foundation

extension UserDefaults {
	private enum Keys {
		static let lastViewedDate = "lastViewedDate"
	}
	
	var lastViewedDate: Date? {
		get {
			if let timeInterval = self.value(forKey: Keys.lastViewedDate) as? TimeInterval {
				return Date(timeIntervalSince1970: timeInterval)
			}
			return nil
		}
		set {
			self.setValue(newValue?.timeIntervalSince1970, forKey: Keys.lastViewedDate)
		}
	}
}
