//
//  VisibleModifier.swift
//  AudioBookApp
//
//  Created by Samuel Pinheiro Junior on 2025-10-07.
//


import SwiftUI

/// A custom `ViewModifier` that conditionally renders a view based on a Boolean value.
///
/// Use `VisibleModifier` to show or hide a view depending on the `visible` flag.
/// When `visible` is `true`, the view is rendered normally; when `false`, the view is hidden
/// and not included in the view hierarchy.
///
/// Example usage:
/// ```swift
/// Text("Now you see me")
///     .modifier(VisibleModifier(visible: true))
///
/// Text("Now you don't")
///     .modifier(VisibleModifier(visible: false))
/// ```
///
/// You can also simplify usage by creating an extension for easier syntax:
/// ```swift
/// extension View {
///     func visible(_ isVisible: Bool) -> some View {
///         self.modifier(VisibleModifier(visible: isVisible))
///     }
/// }
///
/// // Usage:
/// Text("Hello")
///     .visible(isTextVisible)
/// ```
///
/// - Note: When `visible` is `false`, the view is **not part of the layout**.
///   If you need the view to remain in the layout but be invisible,
///   consider using `.opacity(0)` or `.hidden()` instead.
///
public struct VisibleModifier: ViewModifier {
    
    private let visible: Bool
    
    public init(visible: Bool) {
        self.visible = visible
    }
    
    public func body(content: Content) -> some View {
        if visible {
            content
        }
    }
}

extension View {
    /// Use `VisibleModifier` to show or hide a view depending on the `visible` flag.
    /// When `visible` is `true`, the view is rendered normally; when `false`, the view is hidden
    /// and not included in the view hierarchy.
    public func visible(_ visible: Bool) -> some View {
        modifier(VisibleModifier(visible: visible))
    }
}
