//
//  ViewController.swift
//  Walkthrough
//
//  Created by sz ashik on 7/15/18.
//  Copyright © 2018 sz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    
    var dataSurce: [TutData] = TutData.getDummyData()
    
    var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        let scrollViewHeight = scrollView.frame.height
        let scrollViewWidth = scrollView.frame.width
        
        for (index, data) in dataSurce.enumerated() {
            let view = UIView(frame: CGRect(x: scrollViewWidth * CGFloat(index), y: 0, width: scrollViewWidth, height: scrollViewHeight))
            view.backgroundColor = data.color
            scrollView.addSubview(view)
        }
        
        scrollView.contentSize = CGSize(width: scrollViewWidth * CGFloat(dataSurce.count), height: scrollViewHeight)
        scrollView.delegate = self
        pageControl.currentPage = 0
        titleLabel.text = dataSurce[1].title
    }
    
    @IBAction func skipAction(_ sender: UIButton) {
        let offsetPoint = scrollView.contentSize.width - scrollView.frame.width
        if offsetPoint > 0 {
            let endOffset = CGPoint(x: offsetPoint, y: 0)
            scrollView.setContentOffset(endOffset, animated: true)
            let data = dataSurce[dataSurce.count-1]
            titleLabel.slideIn(durateion: 0.8, direction: kCATransitionFromRight)
            titleLabel.text = data.title
            skipButton.isHidden = true
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        pageControl.currentPage = Int(currentPage)
        
        let data = dataSurce[Int(currentPage)]
        
        if Int(currentPage) != (dataSurce.count-1) {
            skipButton.isHidden = false
        } else {
            skipButton.isHidden = true
        }
        
        
        if lastContentOffset > scrollView.contentOffset.x {
            print("moved right")
            titleLabel.slideIn(durateion: 0.8, direction: kCATransitionFromLeft)
            titleLabel.text = data.title
        } else if lastContentOffset < scrollView.contentOffset.x {
            print("moved left")
            titleLabel.slideIn(durateion: 0.8, direction: kCATransitionFromRight)
//            titleLabel.slideIn(direction: kCATransitionFromRight)
            titleLabel.text = data.title
        } else {
            print("did not moved")
        }
        lastContentOffset = scrollView.contentOffset.x
        
    }
}


struct TutData {
    var title: String
    var color: UIColor
    
    static func getDummyData() -> [TutData] {
        var data: [TutData] = []
        let firstData = TutData(title: "Welcome to the frist screen", color: .blue)
        let secondData = TutData(title: "This is second screen to show", color: .cyan)
        let thirdData = TutData(title: "This is final screen. Hope you have a good journy", color: .purple)
        data.append(firstData)
        data.append(secondData)
        data.append(thirdData)
        return data
    }
}

