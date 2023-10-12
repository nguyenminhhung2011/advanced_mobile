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
* Database: MySQl
* Backend: SpringBoot

<br>

## 👨‍💻 Members
* Nguyễn Minh Hưng: 20120491
* Trương Huỳnh Đức Hoàng: 20120483
* Data: Lê Xuân Huy - 20120495
* Data and support backend: Trần Nhât Nguyên - 20120340

<br>

## 💻Backend
https://github.com/nguyenminhhung2011/dream-ticket

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
|     |- model_state.dart
|     |- state.dart
|     |- event.dart
|     |- bloc.dart
|- app.dart
|- main.dart

```

<br>

## 🐸Configuration file.

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

## 📱 UI

### 🐳Mobile
|  Light1 | Dark1 | Light2 | Dark2 | Light3 | Dark3 | 
|:--:|:--:|:--:|:--:|:--:|:--:|
|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/4b009430-cb31-4c67-ac9c-27827d4fa5fc)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/a90dfa21-d2e9-4f5b-9d70-3e16fdd6c629)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/bcc33bad-2a61-4307-9469-0d0434a96a43)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/9d9ca3a9-3918-4bc7-ab01-91dc1fcef49b)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/845167a9-0e54-4c02-90a8-68f23861a391)|![image](https://github.com/nguyenminhhung2011/Flight-Booking/assets/90996598/85c9e589-e6f0-4591-8f90-b4687e1dcc75)|
