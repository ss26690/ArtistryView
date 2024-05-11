//
//  ViewController.swift
//  ScrollableGrid
//
//  Created by Saurav Sagar on 11/05/24.
//

import UIKit

class GalleryVC: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var imageViewSize: Int = 0
    var loadingLabel: UILabel!
    
    private var viewModel: GalleryViewModel =  GalleryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateImageViewSize()
        configuration()
    }
    
    // Adding Loading Indicator
    func addLoadingLabel() {
        let midY = (view.bounds.maxY / 2) - 50
        loadingLabel = UILabel(frame: CGRect(x: 0, y: midY, width: view.bounds.width, height: 200))
        loadingLabel.backgroundColor = .clear
        loadingLabel.textColor = .black
        loadingLabel.text = "Loading..."
        loadingLabel.textAlignment = .center
        view.addSubview(loadingLabel)
    }
}

// API Handling
extension GalleryVC {
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchImages()
    }
    
    // Data Binding
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            DispatchQueue.main.async{
                switch event {
                case .loading:
                    self.addLoadingLabel()
                case .stopLoading:
                    self.loadingLabel?.removeFromSuperview()
                case .dataLoaded:
                    self.galleryCollectionView.reloadData()
                case .error(let error):
                    debugPrint(error)
                }
            }
        }
    }
}

// MARK: Collection View Handling
extension GalleryVC: UICollectionViewDelegate {}

extension GalleryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCVCell", for: indexPath) as? ImageCVCell {
            cell.image = viewModel.images[indexPath.item]
            return cell
        }
    
        return UICollectionViewCell()
    }
}

extension GalleryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageViewSize - 10, height: imageViewSize - 10)
    }
    
    // Show a 3-column square image grid. The images should be center-cropped.
    func calculateImageViewSize() {
        imageViewSize = Int(galleryCollectionView.bounds.size.width / 3)
    }
}
