# AR Comic Effect

![AppIcon](https://user-images.githubusercontent.com/66309582/154791489-1936c2b6-203b-437c-8b0b-e9e62c327864.png)

A minimal iOS AR app with the Comic Postprocess Effect.

- Xcode 13.2.1
- Target: iOS / iPadOS 15.0+
- SwiftUI, ARKit, RealityKit 2, Core Image

In iOS 15.0+, you can apply postprocess effects to a RealityKit scene after RealityKit renders it.
This app applies the CIComicEffect filter of Core Image to the AR scene rendered by RealityKit.

This is a minimal implementation. Replace the Core Image Filter with your favorite one
,and replace the USDZ file in the project with your favorite 3d model data.
Then you will get your iOS AR app.

## References

1. [Article: Applying Core Image Filters as a Postprocess Effect](https://developer.apple.com/documentation/realitykit/applying_core_image_filters_as_a_postprocess_effect)
2. [Sample Code: Implementing Special Rendering Effects with RealityKit Postprocessing](https://developer.apple.com/documentation/realitykit/implementing_special_rendering_effects_with_realitykit_postprocessing)
3. [Core Image Filter Reference](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html)

![Pict1_320](https://user-images.githubusercontent.com/66309582/154791497-b5df3dbe-93a5-4bc9-bc04-63b10ce3c028.png)
![Pict1_320](https://user-images.githubusercontent.com/66309582/154791511-c8ca6bbd-cbd4-468c-80d4-ca2d0313fbce.png)
![GIF1](https://user-images.githubusercontent.com/66309582/154791519-3a8ba6aa-4174-466b-a8ec-0dfc362867f2.gif)

![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)

