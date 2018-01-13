//
//  HighScoreModel+CoreDataProperties.swift
//  2048
//
//  Created by Artem Bobrov on 13.01.2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//
//

import Foundation
import CoreData


extension HighScoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HighScoreModel> {
        return NSFetchRequest<HighScoreModel>(entityName: "HighScoreModel")
    }

    @NSManaged public var value: Int64

}
