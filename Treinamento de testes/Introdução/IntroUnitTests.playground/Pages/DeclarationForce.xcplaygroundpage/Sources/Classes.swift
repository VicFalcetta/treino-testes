import UIKit

public class MyView: UIView {

    public init() {
        super.init(frame: .zero)
        backgroundColor  = .red
        print(" >>>>>>> INIT")
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print(" >>>>>>> DEINIT")
    }
}

public class ClassTest: NSObject {

    public init(_ c: CollaboratorTest) {
        print(" >>>>>>> INIT")
    }

    deinit {
        print(" >>>>>>> DEINIT")
    }

    public func method1() {
        print(" >>>> METHOD 1")
    }

    public func method2() {
        print(" >>>> METHOD 2")
    }

}

public class CollaboratorTest: NSObject {

    public override init() {
        print(" >>>>>>> INIT Collaborator")
    }

    deinit {
        print(" >>>>>>> DEINIT Collaborator")
    }

}
