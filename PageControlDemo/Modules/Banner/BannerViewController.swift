//
//  ViewController.swift
//  PageControlDemo
//
//  Created by Adolfho Athyla on 23/02/19.
//  Copyright © 2019 a7hyla. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupSlideScrollView(slides: createSlides())
        configurePageControl()
    }

    // MARK: - create views
    func createSlides() -> [Slide] {
        let slide1 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.label.text = "1"
        
        let slide2 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.label.text = "2"
        
        let slide3 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.label.text = "3"
        
        let slide4 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.label.text = "4"
        
        return [slide1, slide2, slide3, slide4]
    }
    
    // MARK: - configure scroll view
    func setupSlideScrollView(slides: [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    // MARK: - configure page control
    func configurePageControl() {
        pageControl.numberOfPages = createSlides().count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    
    // MARK: - update layout when change orientation
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: createSlides())
    }
    
}

extension BannerViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
