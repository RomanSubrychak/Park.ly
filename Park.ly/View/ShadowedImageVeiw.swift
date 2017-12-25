//
//  ShadowedImageVeiw.swift
//  Park.ly
//
//  Created by Roman Subrychak on 12/25/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class ShadowedImageVeiw: UIImageView {
	
	override func awakeFromNib() {
		
		self.layer.shadowRadius = 20
		self.layer.shadowOpacity = 0.5
		self.layer.shadowColor = UIColor.black.cgColor
		
	}

}
