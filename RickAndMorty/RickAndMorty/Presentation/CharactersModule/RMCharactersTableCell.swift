import UIKit

final class RMCharactersTableCell: UITableViewCell {
  
  private lazy var titleLabel = UILabel()
  private lazy var avatarImage = UIImageView()
  private var imageFetchTask: Task<(), Never>?
  
  var rmCharacterModel: RMCharacterViewModelProtocol? {
    didSet {
      configure()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    avatarImage.image = nil
    imageFetchTask?.cancel()
  }
  
  private func configureUI() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(avatarImage)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    avatarImage.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.textColor = .black
    avatarImage.backgroundColor = .green
    avatarImage.layer.cornerRadius = 20
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      avatarImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
      avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
      avatarImage.heightAnchor.constraint(equalToConstant: 40),
      avatarImage.widthAnchor.constraint(equalToConstant: 40),
      avatarImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    ])
  }
  
  private func configure() {
    guard let model = rmCharacterModel else { return }
    titleLabel.text = model.name
    imageFetchTask = Task {
      do {
        let image = try await model.loadImage()
        DispatchQueue.main.async { [weak self] in
          guard let self else { return }
          self.avatarImage.image = image
        }
      } catch {
        avatarImage.image = UIImage(named: "image-error")
      }
    }
  }
}
