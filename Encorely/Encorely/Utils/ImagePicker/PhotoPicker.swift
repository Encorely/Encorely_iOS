import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    var onPick: (UIImage?) -> Void

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(onPick: onPick) }

    final class Coordinator: NSObject, PHPickerViewControllerDelegate {
        private let onPick: (UIImage?) -> Void
        init(onPick: @escaping (UIImage?) -> Void) { self.onPick = onPick }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard
                let provider = results.first?.itemProvider,
                provider.canLoadObject(ofClass: UIImage.self)
            else {
                DispatchQueue.main.async { [self] in self.onPick(nil) }
                return
            }

            provider.loadObject(ofClass: UIImage.self) { [weak self] reading, _ in
                DispatchQueue.main.async {
                    self?.onPick(reading as? UIImage)
                }
            }
        }
    }
}
