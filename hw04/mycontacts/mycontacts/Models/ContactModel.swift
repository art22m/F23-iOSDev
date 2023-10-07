import UIKit

// MARK: - ContactModel

struct ContactModel {
    
    var image: UIImage?
    var name: String
    var description: String
    
}

// MARK: - ContactModelStub

struct ContactModelsStub {
    
    static var defaultDescription = """
        Lorem Ipsum is simply dummy text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown
        printer took a galley of type and scrambled it to make a type specimen book.
        It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
        It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,
        and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
    """
    
    let contacts: [ContactModel] = [
        .init(image: UIImage(systemName: "doc.richtext"), name: "Artem", description: defaultDescription),
        .init(image: UIImage(systemName: "xmark.circle"), name: "Ivan", description: defaultDescription),
        .init(image: UIImage(systemName: "star"), name: "Vagif", description: defaultDescription),
        .init(image: UIImage(systemName: "airplane"), name: "Timur", description: defaultDescription),
        .init(image: UIImage(systemName: "house"), name: "Helen", description: defaultDescription),
        .init(image: UIImage(systemName: "keyboard"), name: "Anton", description: defaultDescription),
        .init(image: UIImage(systemName: "doc.richtext.fill"), name: "Maksim", description: defaultDescription),
        .init(image: UIImage(systemName: "doc"), name: "Dima", description: defaultDescription),
        .init(image: UIImage(systemName: "bell"), name: "Danis", description: defaultDescription),
        .init(image: UIImage(systemName: "note"), name: "Arnold", description: defaultDescription),
        .init(image: UIImage(systemName: "doc.append.fill"), name: "Denis", description: defaultDescription),
        .init(image: UIImage(systemName: "doc.append"), name: "Alex", description: defaultDescription),
        .init(image: UIImage(systemName: "doc.richtext"), name: "Egor", description: defaultDescription),
        .init(image: UIImage(systemName: "note.text"), name: "Misha", description: defaultDescription),
    ]
    
}

