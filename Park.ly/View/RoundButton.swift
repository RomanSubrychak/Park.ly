//
//  RoundButton.swift
//  Park.ly
//
//  Created by Roman Subrychak on 12/25/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
	
	override func awakeFromNib() {
		self.layer.cornerRadius = self.frame.height / 2
	}
}
