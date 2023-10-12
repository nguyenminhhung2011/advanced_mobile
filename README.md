# Advanced mobile
![os](https://img.shields.io/badge/-android-32DE84)
![framework](https://img.shields.io/badge/-dart-2196F3)
![framework](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/aa5ec898-994f-4ad0-b0dc-41c99281a9a3)

<br>

<p align="center">
</p>
<p align="center">
<b>LetTutor</b>
<br/>
</p>

## 📄 Introduction
LetTutor is the mobile app learn English one to one
<br>

## 📲All Features

### 🖱️Account
* Account registration
* Checking constraints for username, password re-entry, etc.
* Account activation via email
* System login
* Password reset and password reset via email
* Login with Google

#### 🐼Viewing and searching for teachers
* Displaying a list of teachers
* Displaying specialties and filtering teachers by specialties
* Adding teachers to the favorites list
* Viewing the favorites list of teachers
* Searching for teachers
* Pagination for search results
* Grouping search results
* Displaying search results
* Registering as a teacher
#### ✈️Viewing class schedules

* Displaying total number of hours of classes
* Displaying upcoming classes on the homepage and supporting participation in upcoming classes
* Displaying registered class schedules
* Pagination for class schedules
* Viewing the history of past classes
* Cancelling a class

#### 🛬Joining a class with video call

* Initiating video call with Jitsi
* Displaying waiting time before the class starts
* Timing the duration of the class

#### 💂‍♀️Application logo
 

#### 💵Viewing curriculum

* Viewing the list of curricula
* Searching for curricula
* Pagination for curriculum
* Viewing detailed description of a curriculum
* Displaying detailed content of a curriculum
#### 🐸Account management and application configuration

* Profile management (updating information, avatar)
* Application settings
* Multilingual support (English and Vietnamese)
* Changing themes (dark & white)

<br>

## 💻 Tech
* Language: Dart, java
* Framework: Flutter

<br>

## 👨‍💻 Members
* Nguyễn Minh Hưng: 20120491


<br>



<br>

## 🐼 Layer
* The project applies the clean architecture principles to implement the code.

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
|- presentation_mobile/
|- presentation/
|  |- screens/ 
|  |- widgets/
|  |- bloc/
|     |- state.dart
|     |- event.dart
|     |- bloc.dart
|- app.dart
|- main.dart

```

<br>

## 🐸Configuration file.
Multi-environment configuration (DEV/PRODUCTION) typically involves setting up different configurations for different environments to ensure the application behaves differently based on the environment it is deployed in. 
``` dart
|- configurations/
|  |- env/
|     |- env_prod.dart
          final Map<String, dynamic> environmentProd = {
            'name': 'Flight Booking',
            'environment': 'prod',
            'baseUrl': 'http://192.168.1.104:8080/',
            'mode': 'mobile', // => change web for web version and change to mobile for mobile version 
          };
|  |- configurations.dart 
|  |- defautl_config.dart
```

<br>

## 🌆 Using stream and rx dart for state management 

### 🌟 Stream data 

```dart
final Stream<bool?> loading$;
final loadingController = BehaviorSubject<bool>.seeded(false);
```

### 🌟 Stream actions 
```dart
final Function0<void> getBooInfo;
final getHistoryController = PublishSubject<void>();
```
<br>

### 🌟 Update stream data by data get from usecase
```dart
 final message$ = Rx.merge<AuthState>([
      submit$
          .where((isValid) => isValid)
          .withLatestFrom(credential$, (_, Credential credential) => credential)
          .exhaustMap((credential) {
        try {
          return login
              .login(
                email: credential.email,
                password: credential.password,
              )
              .doOn(
                ///[loading state] set loading after submit
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(_responseToMessage);
        } catch (e) {
          return Stream<AuthState>.error(
            SignInErrorMessage(message: e.toString()),
          );
        }
      }),
      submit$
          .where((isValid) => !isValid)
          .map((_) => const InvalidFormatMessage()),
    ]).whereNotNull().share();
```
### 👁️👁️ And display to UI by StreamBuilder 
### ⚠️⚠️ listen state in UI
```dart
HomeBloc get _bloc => BlocProvider.of<HomeBloc>(context);
Object? listen;

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listen ??= _bloc.state$.flatMap(handleState).collect();

    _bloc.fetchData();
    // dom something
  }
Stream<void> handleState(state) async* {
    if (state is FetchDataCourseFailed) {
      log('🌟 [Fetch data course] ${state.message}');
      return;
    }
    if (state is FetchDataCourseSuccess) {
      log('🐛 [Fetch data success] ${state.message}');
      return;
    }
  }
```
## 📱 UI

### 🐳Mobile
|  Light1 | Dark1 | Light2 | Dark2 | Light3 | Dark3 | 
|:--:|:--:|:--:|:--:|:--:|:--:|
|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/4b009430-cb31-4c67-ac9c-27827d4fa5fc)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/a90dfa21-d2e9-4f5b-9d70-3e16fdd6c629)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/bcc33bad-2a61-4307-9469-0d0434a96a43)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/9d9ca3a9-3918-4bc7-ab01-91dc1fcef49b)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/845167a9-0e54-4c02-90a8-68f23861a391)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/85c9e589-e6f0-4591-8f90-b4687e1dcc75)|
