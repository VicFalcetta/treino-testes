import Foundation

public struct Coffe {
    public var haveMilk: Bool
    public var isStrong: Bool
}

public class CoffeMaker {

    public init() { }

    public func makeLatte() -> Coffe {
        return Coffe(haveMilk: true, isStrong: false)
    }

    public func makeEspresso() -> Coffe {
        return  Coffe(haveMilk: false, isStrong: true)
    }

}
