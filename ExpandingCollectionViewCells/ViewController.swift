//
//  ViewController.swift
//  ExpandingCollectionViewCells
//
//  Created by C4Q on 7/17/19.
//  Copyright © 2019 Vikash Hart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let mainView = MainView()

    let cellSpacing: CGFloat = 20
    var numberOfCells: CGFloat = 1
    let numberOfSpaces: CGFloat = 2

    private var hiddenCells: [MainCollectionViewCell] = []
    private var expandedCell: MainCollectionViewCell?
    private var isStatusBarHidden = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    }

    private func configureConstraints() {
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.contentOffset.y < 0 ||
            collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.height {
            return
        }


        let dampingRatio: CGFloat = 0.8
        let initialVelocity: CGVector = CGVector.zero
        let springParameters: UISpringTimingParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)


        self.view.isUserInteractionEnabled = false

        if let selectedCell = expandedCell {
            isStatusBarHidden = false

            animator.addAnimations {
                selectedCell.collapse()

                for cell in self.hiddenCells {
                    cell.show()
                }
            }

            animator.addCompletion { _ in
                collectionView.isScrollEnabled = true

                self.expandedCell = nil
                self.hiddenCells.removeAll()
            }
        } else {
            isStatusBarHidden = true

            collectionView.isScrollEnabled = false

            let selectedCell = collectionView.cellForItem(at: indexPath)! as! MainCollectionViewCell
            let frameOfSelectedCell = selectedCell.frame

            expandedCell = selectedCell
            hiddenCells = collectionView.visibleCells.map { $0 as! MainCollectionViewCell }.filter { $0 != selectedCell }

            animator.addAnimations {
                selectedCell.expand(in: collectionView)

                for cell in self.hiddenCells {
                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
                }
            }
        }


        animator.addAnimations {
            self.setNeedsStatusBarAppearanceUpdate()
        }

        animator.addCompletion { _ in
            self.view.isUserInteractionEnabled = true
        }

        animator.startAnimation()
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - (self.cellSpacing * self.numberOfSpaces)) / self.numberOfCells
        let height: CGFloat = width * 0.66
        return CGSize(width: width , height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.cellSpacing, left: self.cellSpacing, bottom: self.cellSpacing, right: self.cellSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellSpacing
    }
}
