enum FilterType { price, compare, categories }

extension FilterCheck on FilterType {
  bool get isPrice => this == FilterType.price;
  bool get isCompare => this == FilterType.compare;
  bool get isCategories => this == FilterType.categories;
}

class FilterResponse {
  final FilterType filterType;
  final int locationIndex;
  double? fromPrice;
  double? toPrice;
  List<String>? categorySelected;
  List<String>? compareSelected;
  FilterResponse({
    this.toPrice,
    this.fromPrice,
    this.compareSelected,
    this.categorySelected,
    required this.filterType,
    required this.locationIndex,
  });

  setFromPrice(double fromPrice) {
    this.fromPrice = fromPrice;
  }

  setToPrice(double toPrice) {
    this.toPrice = toPrice;
  }

  addCategorySelected(String category) {
    if (categorySelected != null) {
      categorySelected!.add(category);
    }
  }

  removeCategorySelected(String category) {
    if (categorySelected != null) {
      categorySelected!.removeWhere((element) => element == category);
    }
  }

  addCompareSelected(String compare) {
    if (compareSelected != null) {
      compareSelected!.add(compare);
    }
  }

  removeCompareSelected(String compare) {
    if (compareSelected != null) {
      compareSelected!.removeWhere((element) => element == compare);
    }
  }
}
