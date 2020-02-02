//
//  PromotionCell.swift
//  MusicPlayer
//
//  Created by ebuser on 2018/03/16.
//  Copyright © 2018 ebuser. All rights reserved.
//

import UIKit

class PromotionCell: UICollectionViewCell {
    
    lazy var pages: [UIViewController] = {
        return [
            getViewController(at: 0),
            getViewController(at: 1),
            getViewController(at: 2),
            getViewController(at: 3),
            getViewController(at: 4),
        ]
    }()
    
    let pageViewController =
        UIPageViewController(transitionStyle: .scroll,
                             navigationOrientation: .horizontal,
                             options: nil)
    
    let pageControl = UIPageControl()
    
    override func awakeFromNib() {
        contentView.addSubview(pageViewController.view)
        

        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        pageViewController.view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        pageViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        pageControl.numberOfPages = 5
        pageControl.isUserInteractionEnabled = false
        contentView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 6).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        if let firstVC = pages.first {
            pageViewController.setViewControllers([firstVC],
                                                  direction: .forward,
                                                  animated: false)
        }
    }
    
    func getViewController(at index: Int) -> PromotionImageVC {
        return PromotionImageVC(index: index)
    }
}

extension PromotionCell: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first else { return }
        guard let viewControllerIndex = pages.firstIndex(of: currentViewController) else { return }
        pageControl.currentPage = viewControllerIndex
    }
}

class PromotionImageVC: UIViewController {
    let index: Int
    let imageView: UIImageView
    
    init(index: Int) {
        self.index = index
        imageView = UIImageView()
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "promotion\(index + 1)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
