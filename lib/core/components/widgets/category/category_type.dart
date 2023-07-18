enum CategoryType {
  expandCategory, // done 80%
  listCategory, // done
  textCategory,
  selectedCategory; // done

  bool get isTextCategory => this == CategoryType.textCategory;
  bool get isExpandCategory => this == CategoryType.expandCategory;
  bool get isSelectedCategory => this == CategoryType.selectedCategory;
}
