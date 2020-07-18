//

import Foundation
import UIKit.UIImage

final class CharacterThumbnailStore {

    private init() {
        createThumbnailsPath()
    }

    static let shared = CharacterThumbnailStore()

    private let thumbnailDir = "thumbnails"

    private var thumbnailsPath: URL {
        URL.documentsPath.appendingPathComponent(thumbnailDir, isDirectory: true)
    }

    private func getPathOfThumbnail(withId id: Int) -> URL {
        return thumbnailsPath.appendingPathComponent(String(id))
    }

    private func createThumbnailsPath() {
        do {
            try FileManager.default.createDirectory(at: thumbnailsPath, withIntermediateDirectories: true)
        } catch {
            debugPrint(error)
        }
    }

    func save(_ image: UIImage, withId id: Int) {
        guard let data = image.pngData() else { return }

        let path = getPathOfThumbnail(withId: id)

        do {
            try data.write(to: path)
        } catch {
            debugPrint(error)
        }
    }

    func load(withId id: Int) -> UIImage? {
        let path = getPathOfThumbnail(withId: id)

        var thumbnail: UIImage?

        do {
            let data = try Data(contentsOf: path)
            thumbnail = UIImage(data: data)
        } catch {
            debugPrint(error)
        }

        return thumbnail
    }

    func delete(withId id: Int) {
        let path = getPathOfThumbnail(withId: id)

        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            debugPrint(error)
        }
    }

}
