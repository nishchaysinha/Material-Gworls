
import ArgumentParser  // Available from Apple: https://github.com/apple/swift-argument-parser
import Foundation
import os
import RealityKit
import Metal

private let logger = Logger(subsystem: "com.apple.sample.photogrammetry",
                            category: "HelloPhotogrammetry")

/// Checks to make sure at least one GPU meets the minimum requirements for object reconstruction. At
/// least one GPU must be a "high power" device, which means it has at least 4 GB of RAM, provides
/// barycentric coordinates to the fragment shader, and is running on an Apple silicon Mac or an Intel Mac
/// with a discrete GPU.

private func supportsObjectReconstruction() -> Bool {
    for device in MTLCopyAllDevices() where
        !device.isLowPower &&
         device.areBarycentricCoordsSupported &&
         device.recommendedMaxWorkingSetSize >= UInt64(4e9) {
        return true
    }
    return false
}
