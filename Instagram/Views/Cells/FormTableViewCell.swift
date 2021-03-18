 //
 //  FormTableViewCell.swift
 //  Instagram
 //
 //  Created by Roy Park on 3/17/21.
 //
 
 import UIKit
 
 // return the value when the user hit the return to the VC
 protocol FormTableViewCellDelegate: AnyObject { // AnyObject that way we could put the property in FormTableViewCell
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
 }
 
 class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    public weak var delegate: FormTableViewCellDelegate? // prevent memory leak retention cycle
    
    private var model: EditProfileFormModel?

    static let identifier = "FormTableViewCell"
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Assign frames
        formLabel.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.width/3,
                                 height: contentView.height)
        field.frame = CGRect(x: formLabel.right + 5,
                             y: 0,
                             width: contentView.width - 10 - formLabel.width,
                             height: contentView.height)
    }
    
    // MARK: - Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // every time user hits the return key, we will call this function
        model?.value = textField.text
        guard let model = model else { return true }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
 }
