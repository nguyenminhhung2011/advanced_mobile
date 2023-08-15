import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/double_extension.dart';

import 'filter_response.dart';

class SearchUtils {
  static String getTextFilter(FilterResponse filterResponse) {
    return switch (filterResponse.filterType) {
      FilterType.price =>
        'From ${(filterResponse.fromPrice ?? 0.0).toCurrency()} to ${(filterResponse.toPrice ?? 0.0).toCurrency()}',
      _ => '# ${filterResponse.categorySelected?.map((e) => '$e ' '') ?? ''}'
    };
  }

  static List<Map<String, dynamic>> viewType = <Map<String, dynamic>>[
    {'title': 'List', 'icon': Icons.list},
    {'title': 'Grid', 'icon': Icons.grid_view_sharp},
  ];
}
