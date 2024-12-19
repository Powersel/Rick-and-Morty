import UIKit

final class CharacterDetailsScreen: UIViewController {
  
  //UI elements
  private lazy var nameLabel = UILabel()
  private lazy var avatarImage = UIImageView()
  
  private let viewModel: RMCharacterViewModelProtocol
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(viewModel: RMCharacterViewModelProtocol) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
    
    self.configureUI()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadData()
  }
  
  private func loadData() {
    Task { [weak self] in
      do {
        let image = try await self?.viewModel.loadImage()
        DispatchQueue.main.async {
          self?.avatarImage.image = image
        }
      } catch {
        throw RMError.invalidUrl
      }
    }
  }
  
  private func configureUI() {
    view.addSubview(avatarImage)
    view.addSubview(nameLabel)
    view.backgroundColor = .gray
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    avatarImage.translatesAutoresizingMaskIntoConstraints = false
    
    nameLabel.textColor = .white
    nameLabel.font = UIFont.systemFont(ofSize: 30)
    nameLabel.text = viewModel.name
    
    avatarImage.backgroundColor = .green
    
    NSLayoutConstraint.activate([
      avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
      avatarImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
      avatarImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
      
      nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
    ])
  }
}
