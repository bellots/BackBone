//
//  UITableViews.swift
//  BackBone
//
//  Created by Andrea Bellotto on 30/01/17.
//  Copyright © 2017 BackBone Srl. All rights reserved.
//

import UIKit

class IntrinsicTableView: UITableView {
    
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: self.contentSize.height)
    }
    
    override func endUpdates() {
        super.endUpdates()
        self.invalidateIntrinsicContentSize()
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        super.reloadRows(at:indexPaths, with: animation)
        self.invalidateIntrinsicContentSize()
    }
    
    override func reloadSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        super.reloadSections(sections, with: animation)
        self.invalidateIntrinsicContentSize()
        
    }
    override func insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        super.insertRows(at: indexPaths, with: animation)
        self.invalidateIntrinsicContentSize()
    }
    
    override func insertSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        super.insertSections(sections, with: animation)
        self.invalidateIntrinsicContentSize()
    }
    
    override func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        super.deleteRows(at: indexPaths, with: animation)
        self.invalidateIntrinsicContentSize()
    }

    override func deleteSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        super.deleteSections(sections, with: animation)
        self.invalidateIntrinsicContentSize()
    }
}



