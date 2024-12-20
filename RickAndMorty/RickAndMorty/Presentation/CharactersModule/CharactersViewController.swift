import UIKit

final class CharactersViewController: UITableViewController {
  
  let presenter: CharactersPresenterProtocol!
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(presenter: CharactersPresenterProtocol) {
    self.presenter = presenter
    
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(RMCharactersTableCell.self, forCellReuseIdentifier: "RMCharactersTableCell")
    loadData()
  }
  
  private func loadData() {
    Task { @MainActor in
      do {
        try await self.presenter.fetchData()
        self.tableView.reloadData()
      } catch {
        throw RMError.invalidUrl
      }
    }
  }
  
  // Table view
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.getCharacterModels().count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == presenter.getCharacterModels().count - 5 {
      loadData()
    }
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RMCharactersTableCell", for: indexPath) as? RMCharactersTableCell else {
      fatalError("RMCharactersTableCell does not exist.")
    }
    let model = presenter.getCharacterModels()[indexPath.row]
    cell.rmCharacterModel = model
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.presentDetailsScreen(with: indexPath.row)
  }
  
  // Table view delegate
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50.0
  }
}
