class PriceModel extends FilterModel {
  final double minPrice;
  final double maxPrice;
  PriceModel({
    this.minPrice = 0.0,
    this.maxPrice = 10000,
    required super.header,
  });
}

class Compare {
  final String headerCategory;
  final String left;
  final String right;
  Compare({
    required this.headerCategory,
    required this.left,
    required this.right,
  });
}

class CompareModel extends FilterModel {
  final List<Compare> compares;
  CompareModel({
    required this.compares,
    required super.header,
  });
}

class CategoryModelSearch extends FilterModel {
  final List<String> categories;

  CategoryModelSearch({
    required String header, // Pass header to the constructor of FilterModel
    this.categories = const <String>[],
  }) : super(header: header); // Call the constructor of FilterModel with header
}

class TreeModel {}

abstract class FilterModel {
  final String header;
  FilterModel({
    required this.header,
  });
}
