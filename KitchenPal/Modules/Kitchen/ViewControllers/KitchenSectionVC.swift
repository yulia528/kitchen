//
//  KitchenSectionVC.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/14/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit

enum DragStatus: Int {
  case Began
  case Moving
  case End
}
protocol KitchentSectionDelegate: class {
  func kitchenSection(sender: KitchenSectionVC, dragStatus:DragStatus)
  func kitchenSection(sender:  KitchenSectionVC, didSelect item: KitchenItemData )
}

class KitchenSectionVC: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  weak var delegate: KitchentSectionDelegate?
  var category: KitchenCategoryData!
  var items: [KitchenItemData]!
  var longPressGesture: UILongPressGestureRecognizer!
    override func viewDidLoad() {
      super.viewDidLoad()
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
      if #available(iOS 11, *) {
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
      } else {
          longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gesture:)))
          collectionView.addGestureRecognizer(longPressGesture)
      }
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  @objc
  func handleLongPress(gesture: UILongPressGestureRecognizer) {
    print("long press")
    switch gesture.state {
    case .began:
      guard let selecteIndex = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
        break
      }
      print("selected Index \(selecteIndex)")
      collectionView.beginInteractiveMovementForItem(at: selecteIndex)
    case .changed:
      collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
    case .ended:
      collectionView.endInteractiveMovement()
    default:
      collectionView.cancelInteractiveMovement()
    }
  }
  
  @available(iOS 11.0, *)
  func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
    if let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath {
      collectionView.performBatchUpdates({
        self.items.remove(at: sourceIndexPath.item)
        self.items.insert(item.dragItem.localObject as! KitchenItemData, at: destinationIndexPath.item)
        
        collectionView.deleteItems(at: [sourceIndexPath])
        collectionView.insertItems(at: [destinationIndexPath])
      }) { (success) in
        print("Success \(success)")
      }
      
      coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
    }
  }
  
  func removeItem(_ item: KitchenItemData) {
    if let index = items.firstIndex(where: { $0.id == item.id }) {
      items.remove(at: index);
      collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
    }
  }
  
  func addItem(_ item: KitchenItemData) {
    items.append(item)
    collectionView.reloadData()
  }

}

extension KitchenSectionVC: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KitchenSectionCell", for: indexPath) as! KitchenSectionCell
    cell.item = items[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.kitchenSection(sender: self, didSelect: items[indexPath.row])
  }

  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    return true
  }

  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    print("move form \(sourceIndexPath.row) to \(destinationIndexPath.row)")
    let item = self.items.remove(at: sourceIndexPath.item)
    self.items.insert(item, at: destinationIndexPath.item)
  }
  
}

@available(iOS 11.0, *)
extension KitchenSectionVC: UICollectionViewDragDelegate {
  func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    print("drag")
    let item = items[indexPath.row]
    let itemProvider = NSItemProvider(object: (item.name ?? "") as NSString)
    let dragItem = UIDragItem(itemProvider: itemProvider)
    dragItem.localObject = item
    return [dragItem]
  }
  
  func collectionView(_ collectionView: UICollectionView, dragSessionWillBegin session: UIDragSession) {
    print("will begin")
    collectionView.dragInteractionEnabled = false
    delegate?.kitchenSection(sender: self, dragStatus: .Began)
  }
  
  func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
    print("end drag")
    delegate?.kitchenSection(sender: self, dragStatus: .End)
    collectionView.dragInteractionEnabled = true
  }
  
}

@available(iOS 11.0, *)
extension KitchenSectionVC: UICollectionViewDropDelegate {
  func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
    if collectionView.hasActiveDrag {
      return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    return UICollectionViewDropProposal(operation: .forbidden)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    print("drop")
    var destinationIndexPath: IndexPath
    if let indexPath = coordinator.destinationIndexPath {
      destinationIndexPath = indexPath
    } else {
      let row = collectionView.numberOfItems(inSection: 0)
      destinationIndexPath = IndexPath(item: row - 1, section: 0)
    }
    
    if coordinator.proposal.operation == .move {
      print("move")
      self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
    }
    
  }
  
  
}
