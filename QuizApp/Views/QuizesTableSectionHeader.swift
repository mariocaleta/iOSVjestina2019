//
//  QuizesTableSectionHeader.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 14/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit
import PureLayout

class QuizesTableSectionHeader: UIView {

    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.darkGray
     //   titleLabel.text = category
     //   if(category == "SPORTS"){
     //       backgroundColor = CategoryType.sports.color
     //   }else if(category == "SCIENCE"){
     //       backgroundColor = CategoryType.science.color
     //   }
        self.addSubview(titleLabel)
        titleLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 16.0)
        titleLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
