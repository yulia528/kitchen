//
//  KitchenVC.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/14/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import UIKit
import MaterialComponents

enum SortingType: Int, CaseIterable {
  case byDate, byName, byRate
  
  var value: String {
    switch self {
    case .byDate:
      return "Sort by date"
    case .byName:
      return "Sort by name"
    case .byRate:
      return "Sort by rate"
    default:
      return ""
    }
  }
}

class KitchenVC: BaseViewController {
    var tabBar: MDCTabBar!
    var sortingBar: UIView!
    var sortingButton: UIButton!
    var lastDropableItem: UICollectionViewCell?
    var collectionTab2: UICollectionView!
    var categorySelectedIndex: Int = 0
    var pages: UIPageViewController!
    var floatingMenu: FloatingMenu!
    var selectedSorting: SortingType = .byDate {
        didSet {
          sortingButton.setTitle(selectedSorting.value, for: .normal)
        }
    }

    var categoriesData: [KitchenCategoryData] = []
    var groupItemsData: [[KitchenItemData]] = []

    var contentsViews = [KitchenSectionVC]()
    
  override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        categoriesData = DataManagement.shared.kitchenData.categories
        groupItemsData = DataManagement.shared.kitchenData.groupItems
        setupHeader()
        setupTabbar()
        setupContentPage()
        // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("frame", self.view.frame);
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

  }
    
    override func setupTopBar() -> MDCAppBarViewController? {
        let appBarViewController = self.setupTopBarDefault()
        appBarViewController.headerView.minimumHeight = AppBarHeight
        return appBarViewController
    }
  
  func randomColor() -> UIColor {
    let r = arc4random() % 256
    let g = arc4random() % 256
    let b = arc4random() % 256
    
    return UIColor(displayP3Red: CGFloat(r) / 256, green: CGFloat(g) / 256, blue: CGFloat(b) / 256, alpha: 1)
  }
  
  var AppBarHeight:CGFloat {
    return 56 + MDCTabBar.defaultHeight(for: .titles)
  }
  
  func setupHeader() {
    topBar?.navigationBar.title = "Kitchen"
    topBar?.navigationBar.titleTextColor = .white
    topBar?.navigationBar.tintColor = .white
    topBar?.navigationBar.rightBarButtonItems = [
      UIBarButtonItem(image: UIImage(named: "Add")?.withRenderingMode(.alwaysTemplate), style: .done, target: nil, action: nil),
      UIBarButtonItem(image: UIImage(named: "Search")?.withRenderingMode(.alwaysTemplate), style: .done, target: nil, action: nil),
    ]
  }
  
  func setupTabbar() {
    let tabBarHeight = MDCTabBar.defaultHeight(for: .titles)
    tabBar = MDCTabBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: tabBarHeight))
    
    var items = [UITabBarItem]()
    for category in self.categoriesData {
      let item = UITabBarItem(title: category.title, image: category.image, tag: 0)
      item.badgeValue = category.badge;
      item.badgeColor = UIColor.red
      items.append(item)
      
    }
    
    tabBar.items = items
    tabBar.selectedItem = items[self.categorySelectedIndex]
    tabBar.alignment = .center
    tabBar.selectedItemTintColor = .white;
    tabBar.unselectedItemTintColor = .init(white: 1, alpha: 0.6)
    tabBar.backgroundColor = AppSetting.shared.color.redmain
    tabBar.itemAppearance = .titles
    tabBar.bottomDividerColor = .clear
    tabBar.inkColor = .init(white: 1, alpha: 0.4)
    tabBar.delegate = self
    self.collectionTab2 = tabBar.view(with: UICollectionView.self)
    
    if #available(iOS 11, *) {
        self.collectionTab2.dropDelegate = self
    }
    
    self.topBar?.headerStackView.bottomBar = self.tabBar;
    self.topBar?.headerStackView.setNeedsLayout()
  }
  
  func setupContentPage() {
    var contentViews_ = [KitchenSectionVC]()
    for (index, category) in self.categoriesData.enumerated() {
      let content = StoryBoardName.Kitchen.storyboard().instance(type: KitchenSectionVC.self)!
      content.items = groupItemsData[index]
      content.category = category
      content.delegate = self
      content.view.tag = index
      contentViews_.append(content)
    }
    
    self.contentsViews = contentViews_

    let pageOptions:[UIPageViewController.OptionsKey: Any] = [
      UIPageViewController.OptionsKey.interPageSpacing: 8,
    ]
    pages = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: pageOptions)
    pages.dataSource = self
    pages.delegate = self
    self.addChild(pages)
    pages.view.backgroundColor = UIColor.white
    self.view.addSubview(pages.view)
    pages.view.translatesAutoresizingMaskIntoConstraints = false
    let pview = pages.view!
    pview.backgroundColor = .white
    if #available(iOS 11.0, *) {
      pview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppBarHeight).isActive = true
    } else {
      // Fallback on earlier versions
      pview.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: AppBarHeight).isActive = true
    }
    pview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    pview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    if #available(iOS 11.0, *) {
      pview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    } else {
      // Fallback on earlier versions
      pview.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
    }
    pages.setViewControllers([contentsViews[categorySelectedIndex]], direction: .forward, animated: true, completion: nil)
  }
  
//  @objc
//  func showSortingPopup(_ sender: UIView) {
//    let controller = ArrayChoiceTableViewController(SortingType.allCases, labels: { (sorting) -> String in
//      return sorting.value
//    }) { (sorting) in
//      self.selectedSorting = sorting
//    }
//    controller.preferredContentSize = CGSize(width: 150, height: 150)
//    showPopup(controller, sourceView: sender)
//  }
//
//  private func showPopup(_ controller: UIViewController, sourceView: UIView) {
//    let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
//    presentationController.sourceView = sourceView
//    presentationController.sourceRect = sourceView.bounds
//    presentationController.permittedArrowDirections = [.down, .up]
//    self.present(controller, animated: true)
//  }
  
}

extension KitchenVC: KitchentSectionDelegate {
  func kitchenSection(sender: KitchenSectionVC, dragStatus: DragStatus) {
    switch dragStatus {
    case .Began:
      pages.view.view(with: UIScrollView.self)?.isScrollEnabled = false
    case .End:
      pages.view.view(with: UIScrollView.self)?.isScrollEnabled = true
    default:
      break
    }
  }
  
  func kitchenSection(sender: KitchenSectionVC, didSelect item: KitchenItemData) {
    
  }
}

// MARK: Tab Bar delegate
extension KitchenVC: MDCTabBarDelegate {
  func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
    guard let index = tabBar.items.firstIndex(of: item) else {
      fatalError("MDCTabBarDelegate given selected item not found in tabBar.items")
    }
    
    if self.categorySelectedIndex != index {
      let direction: UIPageViewController.NavigationDirection = (index - self.categorySelectedIndex) > 0 ? UIPageViewController.NavigationDirection.forward : UIPageViewController.NavigationDirection.reverse
      self.pages.setViewControllers([contentsViews[index]], direction: direction, animated: true, completion: nil)
      self.categorySelectedIndex = index
    }
  }
}

extension KitchenVC: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    let currentIndex = viewController.view.tag
    if currentIndex <= 0 {
      return nil
    }
    
    return contentsViews[currentIndex - 1]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    let currentIndex = viewController.view.tag
    if currentIndex >= contentsViews.count - 1 {
      return nil
    }
    
    return contentsViews[currentIndex + 1]
  }
  
}


extension KitchenVC: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    if let index = pageViewController.viewControllers?.first?.view.tag {
      self.categorySelectedIndex = index;
      self.tabBar.setSelectedItem(self.tabBar.items[index], animated: true)
    }
  }
}


@available(iOS 11, *)
extension KitchenVC: UICollectionViewDropDelegate {
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    
    var destinationIndexPath: IndexPath
    if let indexPath = coordinator.destinationIndexPath {
      destinationIndexPath = indexPath
    } else {
      let row = collectionView.numberOfItems(inSection: 0)
      destinationIndexPath = IndexPath(item: row - 1, section: 0)
    }
    
    print("drop to tab \(destinationIndexPath)")
    
    if coordinator.proposal.operation == .copy {
      print("move")
      lastDropableItem?.layer.borderColor = UIColor.red.cgColor
      lastDropableItem?.layer.borderWidth = 0
      lastDropableItem = nil
      if let item = coordinator.items.first!.dragItem.localObject as? KitchenItemData {
          contentsViews[categorySelectedIndex].removeItem(item)
          contentsViews[destinationIndexPath.row].addItem(item)
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
    if !collectionView.hasActiveDrop || destinationIndexPath == nil || destinationIndexPath!.row == categorySelectedIndex{
      lastDropableItem?.layer.borderWidth = 0
      lastDropableItem = nil
      
      return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    
    if let cell = collectionView.cellForItem(at: destinationIndexPath!) {
      if lastDropableItem != cell {
        lastDropableItem?.layer.borderWidth = 0
        lastDropableItem = nil
        
        cell.layer.borderColor = UIColor.green.cgColor
        cell.layer.borderWidth = 2
        
        lastDropableItem = cell
      }
    }
    return UICollectionViewDropProposal(operation: .copy, intent: .insertIntoDestinationIndexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, dropSessionDidExit session: UIDropSession) {
    print("exitddd")
    lastDropableItem?.layer.borderWidth = 0
    lastDropableItem = nil
  }
  
  func collectionView(_ collectionView: UICollectionView, dropSessionDidEnd session: UIDropSession) {
    lastDropableItem?.layer.borderWidth = 0
    lastDropableItem = nil
  }
  
}




