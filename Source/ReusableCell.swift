//
//  ReusableCell.swift
//  KGNUserInterface
//
//  Created by David Keegan on 1/28/16.
//  Copyright © 2016 David Keegan. All rights reserved.
//

// MARK: - Collection View

/// Subclass of a collection view cell with helpful methods
open class CollectionViewCell: UICollectionViewCell {

    // Public method that returns a string of 
    // the class to be used as a reuseIdentifier.
    open class func reuseIdentifier() -> String {
        return "\(self)"
    }

}

/// Subclass of a collection view with helpful methods
open class CollectionView: UICollectionView {

    // Register a class, uses the reuse identifier from `reuseIdentifier()`
    open func register(classType: CollectionViewCell.Type) {
        self.register(classType, forCellWithReuseIdentifier: classType.reuseIdentifier())
    }

}

// MARK: - Table View

/// Subclass of a table view cell with helpful methods
open class TableViewCell: UITableViewCell {

    // Public method that returns a string of
    // the class to be used as a reuseIdentifier.
    open class func reuseIdentifier() -> String {
        return "\(self)"
    }
    
}

/// Subclass of a table view with helpful methods
open class TableView: UITableView {

    // Register a class, uses the reuse identifier from `reuseIdentifier()`
    open func register(classType: TableViewCell.Type) {
        self.register(classType, forCellReuseIdentifier: classType.reuseIdentifier())
    }
    
}
