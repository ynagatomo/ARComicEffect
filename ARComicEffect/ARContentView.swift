//
//  ARContentView.swift
//  ARComicEffect
//
//  Created by Yasuhito NAGATOMO on 2022/02/19.
//

import SwiftUI
import ARKit
import RealityKit

struct ARContentView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARViewController

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> ARViewController {
        let viewController = ARViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) { }

    class Coordinator: NSObject {
        var parent: ARContentView
        init(_ parent: ARContentView) {
            self.parent = parent
        }
    }
}

class ARViewController: UIViewController {
    private let assetName = "suzanne.usdz"
    private let assetPosition = SIMD3<Float>([0.0, 0.0, -0.5])
    private let assetScale = SIMD3<Float>([1.0, 1.0, 1.0])
    private var ciContext: CIContext!

    override func viewDidAppear(_ animated: Bool) {
        let arView = ARView(frame: .zero)
        view = arView

        let anchorEntity = AnchorEntity()
        arView.scene.addAnchor(anchorEntity)

        var entity: Entity!
        do {
            entity = try Entity.load(named: assetName)
            entity.scale = assetScale
            entity.position = assetPosition
            anchorEntity.addChild(entity)
        } catch {
            assertionFailure("Could not load the USDZ asset.")
        }

        arView.renderCallbacks.prepareWithDevice = setupCoreImage
        arView.renderCallbacks.postProcess = postProcessWithCoreImage

        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)

        if let animation = entity.availableAnimations.first {
            entity.playAnimation(animation.repeat())
        }
    }

    func setupCoreImage(device: MTLDevice) {
        ciContext = CIContext(mtlDevice: device)
    }

    func postProcessWithCoreImage(context: ARView.PostProcessContext) {
        guard let filter = CIFilter(name: "CIComicEffect") else {
        // guard let filter = CIFilter(name: "CISpotColor") else {
            fatalError("Unable to create the CIFilter.")
        }
        guard let input = CIImage(mtlTexture: context.sourceColorTexture) else {
            fatalError("Unable to create a CIImage from sourceColorTexture.")
        }
        filter.setValue(input, forKey: kCIInputImageKey)
        guard let output = filter.outputImage else {
            fatalError("Error applying filter.")
        }
        let destination = CIRenderDestination(mtlTexture: context.targetColorTexture,
                                              commandBuffer: context.commandBuffer)
        destination.isFlipped = false
        _ = try? ciContext.startTask(toRender: output, to: destination)
    }
}

struct ARContentView_Previews: PreviewProvider {
    static var previews: some View {
        ARContentView()
    }
}
