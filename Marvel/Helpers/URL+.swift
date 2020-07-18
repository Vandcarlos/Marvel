//

import Foundation

extension URL {

    static var documentsPath: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

}
