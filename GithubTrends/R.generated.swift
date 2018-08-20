//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 5 colors.
  struct color {
    /// Color `bottom_half_background`.
    static let bottom_half_background = Rswift.ColorResource(bundle: R.hostingBundle, name: "bottom_half_background")
    /// Color `common`.
    static let common = Rswift.ColorResource(bundle: R.hostingBundle, name: "common")
    /// Color `description`.
    static let description = Rswift.ColorResource(bundle: R.hostingBundle, name: "description")
    /// Color `name`.
    static let name = Rswift.ColorResource(bundle: R.hostingBundle, name: "name")
    /// Color `text`.
    static let text = Rswift.ColorResource(bundle: R.hostingBundle, name: "text")
    
    /// `UIColor(named: "bottom_half_background", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func bottom_half_background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.bottom_half_background, compatibleWith: traitCollection)
    }
    
    /// `UIColor(named: "common", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func common(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.common, compatibleWith: traitCollection)
    }
    
    /// `UIColor(named: "description", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func description(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.description, compatibleWith: traitCollection)
    }
    
    /// `UIColor(named: "name", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func name(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.name, compatibleWith: traitCollection)
    }
    
    /// `UIColor(named: "text", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func text(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.text, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `GithubProjectsSample.json`.
    static let githubProjectsSampleJson = Rswift.FileResource(bundle: R.hostingBundle, name: "GithubProjectsSample", pathExtension: "json")
    
    /// `bundle.url(forResource: "GithubProjectsSample", withExtension: "json")`
    static func githubProjectsSampleJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.githubProjectsSampleJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `avatar`.
    static let avatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "avatar")
    
    /// `UIImage(named: "avatar", bundle: ..., traitCollection: ...)`
    static func avatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.avatar, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `projectCell`.
    static let projectCell: Rswift.ReuseIdentifier<ProjectTableViewCell> = Rswift.ReuseIdentifier(identifier: "projectCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 1 view controllers.
  struct segue {
    /// This struct is generated for `ProjectListViewController`, and contains static references to 1 segues.
    struct projectListViewController {
      /// Segue identifier `projectDetailSegue`.
      static let projectDetailSegue: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, ProjectListViewController, ProjectViewController> = Rswift.StoryboardSegueIdentifier(identifier: "projectDetailSegue")
      
      /// Optionally returns a typed version of segue `projectDetailSegue`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func projectDetailSegue(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, ProjectListViewController, ProjectViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.projectListViewController.projectDetailSegue, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 5 localization keys.
    struct localizable {
      /// Value: %@ forks
      static let forks = Rswift.StringResource(key: "%@ forks", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: %@ stars
      static let stars = Rswift.StringResource(key: "%@ stars", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Error parsing JSON
      static let errorParsingJSON = Rswift.StringResource(key: "Error parsing JSON", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: No Internet connection, please try again later
      static let noInternetConnectionPleaseTryAgainLater = Rswift.StringResource(key: "No Internet connection, please try again later", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: There was a server error, please try again later
      static let thereWasAServerErrorPleaseTryAgainLater = Rswift.StringResource(key: "There was a server error, please try again later", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: %@ forks
      static func forks(_ value1: String) -> String {
        return String(format: NSLocalizedString("%@ forks", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: %@ stars
      static func stars(_ value1: String) -> String {
        return String(format: NSLocalizedString("%@ stars", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: Error parsing JSON
      static func errorParsingJSON(_: Void = ()) -> String {
        return NSLocalizedString("Error parsing JSON", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: No Internet connection, please try again later
      static func noInternetConnectionPleaseTryAgainLater(_: Void = ()) -> String {
        return NSLocalizedString("No Internet connection, please try again later", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: There was a server error, please try again later
      static func thereWasAServerErrorPleaseTryAgainLater(_: Void = ()) -> String {
        return NSLocalizedString("There was a server error, please try again later", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "Main"
      
      static func validate() throws {
        if UIKit.UIImage(named: "avatar") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'avatar' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
          if UIKit.UIColor(named: "text") == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'text' is used in storyboard 'Main', but couldn't be loaded.") }
          if UIKit.UIColor(named: "name") == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'name' is used in storyboard 'Main', but couldn't be loaded.") }
          if UIKit.UIColor(named: "common") == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'common' is used in storyboard 'Main', but couldn't be loaded.") }
          if UIKit.UIColor(named: "bottom_half_background") == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'bottom_half_background' is used in storyboard 'Main', but couldn't be loaded.") }
          if UIKit.UIColor(named: "description") == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'description' is used in storyboard 'Main', but couldn't be loaded.") }
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
