//
//  ViewController.swift
//  GruzRazbor66
//
//  Created by Настя on 16.05.2022.
//

import UIKit
import Agrume
import PhotosUI

class MainViewController: UIViewController {
    // MARK: - Properties
    let property = ["Автомобиль","Цена","Остаток","Код","Артикул"]
    private var model: DetailModel?
    private var selectedImage: Int?
    private var item: ImageCellAddType = .photo
    private let apiController = APIController.shared
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        return imagePickerController
    }()
    
    @available(iOS 14, *)
    private lazy var phPickerViewController: PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 10
        let phPickerController = PHPickerViewController.init(configuration: config)
        phPickerController.delegate = self
        return phPickerController
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanerButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var addPhotoViewContainer: UIView!
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = setDefaultModel()
        setupUI()
        loadImages()
    }
    
    private func setDefaultModel() -> DetailModel {
        let detail = DetailModel(auto: "МАЗ-6430А8-370-011 Тяг...", price: "3 000,00", balance: "5", id: "00001673", vendorCode: "5430-3101012")
        //        detail.addPhotos(photos: [UIImage(named: "Rectangle1")!, UIImage(named: "Rectangle2")!])
        return detail
    }
    
    func setupUI() {
        guard let model = model else { return }
        
        scanerButton.layer.cornerRadius = 6
        scanerButton.clipsToBounds = true
        scanerButton.setTitle("", for: .normal)
        customizeSearchField()
        
        basketButton.clipsToBounds = true
        basketButton.layer.cornerRadius = 6
        
        addPhotoViewContainer.isHidden = !model.photos.isEmpty
        photosCollectionView.isHidden = !addPhotoViewContainer.isHidden
    }
    
    fileprivate func customizeSearchField(){
        searchBar.backgroundColor = UIColor.init(red: 237, green: 237, blue: 237, alpha: 1)
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchTextField.heightAnchor.constraint(equalToConstant: 48),
                searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
                searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
                searchTextField.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor)
            ])
            searchTextField.clipsToBounds = true
            searchTextField.layer.cornerRadius = 6.0
            
            let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.black]
            searchTextField.attributedPlaceholder = NSAttributedString(string: "Поиск по коду", attributes: attributeDict)
            
            let glassIconView = searchTextField.leftView as! UIImageView
            glassIconView.image = glassIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView.tintColor = UIColor.black
        }
    }
    
    private func updateUI() {
        if !(model?.photos.isEmpty ?? true) {
            addPhotoViewContainer.isHidden = true
            photosCollectionView.isHidden = false
        }
    }
    
    private func addPhoto(photo: UIImage) {
        guard let model = model else { return }
        model.photos.append(photo)
        updateUI()
        photosCollectionView.reloadData()
    }
    
    private func loadImages() {
        let params = ["НоменклатураИдентификатор":"5dbb89b8-d027-11ec-9740-002655e90aec"]
        apiController.getProductImages(params: params) { result in
            switch result {
            case .success(let model):
                print(model.name)
                let baseString = model.base64String.decodeBase64()
                let imageData = Data.init(base64Encoded: baseString!)
                let image = UIImage(data: imageData!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    // MARK: - Actions
    @IBAction func addPhotoDidTapped(_ sender: UIButton) {
        presentAddPhotoActionSheet()
    }
}


// MARK: - CollectionViewDelegate and DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.propertyLabel.text = property[indexPath.row]
        switch indexPath.row {
        case 0: cell.valueLabel.text = model?.auto
        case 1: cell.valueLabel.text = model?.price
        case 2: cell.valueLabel.text = model?.balance
        case 3: cell.valueLabel.text = model?.id
        case 4: cell.valueLabel.text = model?.vendorСode
        default: cell.valueLabel.text = "test"
        }
        return cell
    }
}

// MARK: - Helpers
extension MainViewController {
    private func presentAddPhotoActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(pickerAction(sourceType:.camera))
        }
        
        if #available(iOS 14, *) {
            alert.addAction(phPickerAction())
        } else {
            alert.addAction(pickerAction(sourceType:.photoLibrary))
        }
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.popoverPresentationController?.sourceView = self.photosCollectionView
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    private func pickerAction(sourceType: UIImagePickerController.SourceType) -> UIAlertAction {
        var title: String {
            switch sourceType {
            case .photoLibrary:
                return item.actionAddFromLibraryTitle
            case .camera:
                return item.actionAddTitle
            default:
                return "Choose Media"
            }
        }
        
        return UIAlertAction(title: title, style: .default) { action in
            PhotoAuthCenter.checkCameraAuthentication(in: self) {
                self.chooseMediaWithType(sourceType: sourceType)
            }
        }
    }
    
    @available(iOS 14, *)
    private func phPickerAction() -> UIAlertAction {
        return UIAlertAction(title: item.actionAddFromLibraryTitle, style: .default) { action in
            PhotoAuthCenter.checkLibraryAuthentication(in: self) {
                self.present(self.phPickerViewController, animated: true)
            }
        }
    }
}


// MARK: - CollectionViewDelegate and DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (model?.photos.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let model = model else { return UICollectionViewCell() }
        
        if indexPath.item == model.photos.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainImageAddCell", for: indexPath) as! MainImageAddCell
            cell.addButtonDidTapped = {
                self.presentAddPhotoActionSheet()
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainImageCell", for: indexPath) as! MainImageCell
        cell.imageView.image = model.photos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photos = model?.photos else { return }
        let button = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
        button.tintColor = .white
        let agrume = Agrume(images: photos, startIndex: indexPath.row, background: .colored(.black), dismissal: .withPanAndButton(.standard, button))
        agrume.show(from: self)
    }
    
}

extension MainViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func chooseMediaWithType(sourceType: UIImagePickerController.SourceType) {
        imagePickerController.sourceType = sourceType
        
        imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType) ?? []
        switch item {
        case .photo:
            imagePickerController.mediaTypes = ["public.image"]
        }
        DispatchQueue.main.async {
            self.present(self.imagePickerController, animated: true)
            self.updateUI()
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let photo = info[.originalImage] as? UIImage else { return }
        DispatchQueue.main.async {
            self.addPhoto(photo: photo)
            picker.dismiss(animated: true)
        }
        
    }
}

@available(iOS 14, *)
extension MainViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProviders = results.map {$0.itemProvider}
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { image, error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    if let photo = image as? UIImage {
                        DispatchQueue.main.async {
                            self.addPhoto(photo: photo)
                        }
                    }
                }
            }
        }
    }
}
