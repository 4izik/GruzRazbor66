
import Agrume
import UIKit

protocol OverlayViewDelegate: AnyObject {
  func overlayView(_ overlayView: OverlayView, didSelectAction action: String)
}

/// Example custom image overlay
final class OverlayView: AgrumeOverlayView {
  
  lazy var navigationBar: UINavigationBar = {
    let navigationBar = UINavigationBar()
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    navigationBar.pushItem(UINavigationItem(title: "skljrhflkejrhfljerh"), animated: false)
    return navigationBar
  }()
  
  var portableSafeLayoutGuide: UILayoutGuide {
    if #available(iOS 11.0, *) {
      return safeAreaLayoutGuide
    }
    return layoutMarginsGuide
  }
  
  weak var delegate: OverlayViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    addSubview(navigationBar)
    
    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: portableSafeLayoutGuide.topAnchor),
      navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
      navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
      self.backgroundColor = .black
  }
  
  @objc
  private func selectShare() {
    delegate?.overlayView(self, didSelectAction: "share")
  }
  
  @objc
  private func selectDelete() {
    delegate?.overlayView(self, didSelectAction: "delete")
  }
  
  @objc
  private func selectDone() {
    delegate?.overlayView(self, didSelectAction: "done")
  }
}

