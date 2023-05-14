import UIKit
import Domain
import CleanTools

final class StoreCell: UITableViewCell, NibInstantiatable {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var price: UILabel!
    
    private let viewModel = StoreCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewModel.delegate = self
    }
    
    @IBAction func didPressAddItem(_ sender: Any) {
        Task {
            await viewModel.didPressAddItem()
        }
    }
    
    @IBAction func didPressRemoveItem(_ sender: Any) {
        Task {
            await viewModel.didPressRemoveItem()
        }
    }
    
}

// MARK: - TableViewCellProtocol

extension StoreCell: TableViewCellProtocol {
    
    func configure(with cellData: CellDataProtocol,
                   delegate: AnyObject?) {
        Task {
            await self.viewModel.assign(cellData: cellData)
        }
    }
    
}

// MARK: - StoreCellViewModelDelegate

extension StoreCell: StoreCellViewModelDelegate {
    
    func update(field: StoreCellViewModel.Field) {
        switch field {
            
        case .title(let newTitle):
            title.text = newTitle
            
        case .price(let newPrice):
            price.text = newPrice
            
        case .amount(let newAmount):
            amount.text = newAmount
        }
    }
    
}
