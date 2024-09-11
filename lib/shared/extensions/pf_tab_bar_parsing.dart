enum PFTabBar {
  personality,
  attributes,
  recommendations,
}

extension PFTabBarParsing on PFTabBar {
  String get title {
    switch (this) {
      case PFTabBar.personality:
        return 'Personality';
      case PFTabBar.attributes:
        return 'Attributes';
      case PFTabBar.recommendations:
        return 'Recommendations';
    }
  }
}
