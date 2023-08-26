## 🧑‍💻 flutter_base
![Dashatars](https://github.com/nguyenminhhung2011/flutter_base/assets/90996598/b0db2128-b3cf-4e79-98c0-489054983b8b)

### 🌈 Widget 
| Custom widget | Pull request |
|:--:|:--:|
| 🐼 Tabbar | [🐼init some widgets and custom some widgets](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/1) |
| 🐼 Pagination (list view, grid view) | [🐼 UI/Pagination list view](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/2) |
| 🐼 Category item view | [🐼 UI/category item view](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/3) |
|🐼Category autoscroll |[🐼Category autoscroll ui](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/4)|
|🐼Both category view |[🐼 Both category view](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/5)|
|🐼Group category |[🐼 Group category](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/6)|
|✨ Add header search, category gradient color, masonry grid, bottom model sheet, banner slider |[✨ Add header search + category gradient color + masonry grid + bottom model sheet + banner slider](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/7)|
|🐼Expansion panel list and image stack view|[🐼 Expansion panel list + image stack view](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/8)|
|🐼Tree view|[🐼 New widget tree view ](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/9)|
|🐼Search layout|[🐼 Search layout ](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/10)|
|🐼Setting layout|[🐼 UI/Setting layout ](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/11)|
|🐼line progress with badge in head|[🐼 line progress with badge in head ](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/13)|
|🐼Progress button|[🐼 Progress button ](https://github.com/nguyenminhhung2011/flutter_base_clean_architecture/pull/14)|

### 🐸 Service & controller

| Controller | Pull request|
|:--:|:--:|
|🗽Isolate||
|🗽Speech to text||
|🗽Text to speech||

Flutter Isolate. RxDart
### 🌃 Layer

```
lib/

|- data/
|  |- repositories/  => providing data access
|  |- models/ => representing data structures
|  |- datasources/ => used to communicate with data sources such as a database or API
|     |- local/ 
|     |- remote/ 
|
|- domain/
|  |- repositories/ => communicating with the data.repositories layer
|  |- entities/ => representing objects within the application
|  |- usecases/ => contains the implementation of the application's use cases
|
|- presentation/
|  |- screens/ 
|  |- widgets/
|  |- bloc/
|     |- model_state.dart
|     |- state.dart
|     |- event.dart
|     |- bloc.dart
|- app.dart
|- main.dart

```

