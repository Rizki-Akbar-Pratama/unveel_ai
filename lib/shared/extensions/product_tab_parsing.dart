enum SmilarProductTab {
  smilarMakeup,
  smilarAccessories,
}

extension SmilarProductTabParsing on SmilarProductTab {
  String get title {
    switch (this) {
      case SmilarProductTab.smilarMakeup:
        return 'Smilar Makeup';
      case SmilarProductTab.smilarAccessories:
        return 'Smilar Accessories';
    }
  }
}
