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

* Initiating video call 
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
* Language: Dart
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
            'name': 'letTutor',
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
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/9f75c3cf-431c-4d5e-8ca2-058d0bf6a166)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/cd7e1bf8-afef-4b82-b259-cf6fc835cb95)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/82201caf-0a9b-4bd1-9682-0ad549514e23)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/e349813b-df2e-4496-a9b6-e5fc81c1272f)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/289d83fd-dce2-441f-90cc-7c350da76041)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/f65803d4-f165-4982-bb83-3b0d803cda49)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/25079711-1f2a-4364-ab22-10936e440a42)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/43b6d7a4-b343-4d5b-bbde-edd5857ccf58)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/1b667e9e-24b0-4ea7-a88c-8562f171f384)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/a801557d-6ca1-4f10-9cfa-47cfee5844b8)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/05b2ea30-aad0-4403-8aa9-040e8a3baf4b)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/98aed20c-3d08-4220-a07d-a0c539486304)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/9975b3a2-9dc4-48c1-8917-d1ae997aaba8)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/cf6da043-ef10-4218-b55a-c639e6978442)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/fd739481-d35f-464e-9c14-3b73800ee7eb)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/01cc014c-9f21-41bc-9d28-c080db3a1cd1)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/b252b84d-e461-4e48-bc19-4785f25c2854)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/9bbe6b3a-ae9b-4f0c-80c6-badb2f0c0d15)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/c0d040bd-cbf2-4071-aa33-5b62c039e2f1)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/9338e66f-f2bd-476b-9572-d293c02d2ccb)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/73079cdc-0b28-4d44-bc39-38e57b24dab0)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/37c4426b-7882-4130-b1b0-93142c544eb6)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/00a156d6-a358-4571-a8e8-3bb041f1b6eb)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/a9f29e3b-b013-4e7e-b49d-62d595b48d26)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/f870a003-6f71-46ce-b5f0-b3505991e08a)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/650f482c-9a7d-4541-b962-f444d417e980)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/a5a67419-283f-4766-beb6-ee7f29badb90)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/605be0b7-0616-4cf1-8057-1c5e0bcdc9dd)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/fb8f25f4-5313-4fd0-b5bb-3db53eacf598)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/9e15dd96-0b86-45d2-9d28-13fcc3c73938)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/a7e0467f-d4cd-4b81-8fb0-3a696029a67b)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/a48a5323-23fd-4792-a98c-d61c0844c955)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/64e05dba-ebd5-4ec5-af7e-cea2d26086e5)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/35b0053d-6add-4edb-b230-ec416be5e502)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/b911d31c-47e8-448c-be57-e98520b7a591)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/4949d650-0455-4463-8a83-212f6bddf7a4)
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/2ee59c65-31ba-4b86-a130-d7ef589c489b)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/46647653-6c55-430c-a22c-9532cec1cafe)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/cbedb082-09e2-4bb9-a3c0-6e97d0134b92)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/3964c574-b315-4d93-9801-8c83f2d5ee69)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/500da338-d225-4d3a-929b-fe6cc720ab05)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/c46f99ed-87aa-4a50-a71a-bff5950fe5fa)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/73f8842a-ab21-4e99-900b-d037fed3f520)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/16ec9466-59ad-4389-85a6-4da710bd9e60)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/ac5e0b3f-6037-4423-8b7a-1d7c81d977cc)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/03328010-b173-4741-a6e9-675f0b290527)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/fc47774f-500a-42c2-9386-ab43f5d1de7a)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/2f5767f4-9d42-4972-953c-28ca75e618f1)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/545888ad-6b66-4ff6-8d74-a88166d80825)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/6767fc61-b8e1-4930-bb94-ca6e3b3eef10)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/20da7739-a0eb-4b33-a0a2-bebf35eb6e65)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/6e7e18e5-ce32-4870-8610-4f95ab9e698f)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/5bd2c7d7-42cb-45d8-8872-c34bc15437fe)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/2319bc4b-4d58-4410-8bde-e03a8d118953)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/429f2498-db28-4692-8a00-ff60c0c05de9)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/a6abb71e-470b-43c0-9844-8d0f7fa07369)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/8a4aa11f-fb35-4683-ab53-b2b6c7fd2090)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/e66661e5-4f96-4afb-89c3-992bf07351ce)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/25745e3e-f1f1-473b-bb6f-729f0c974779)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/f8a6976b-1acb-44b2-aa39-80072e5981ac)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/d535803c-d6e4-4739-aa3f-3229769cf507)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/fae77bd9-9f88-43c0-b426-b147ba9beef9)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/3b2da819-878f-4b0e-9815-85ccfd73c660)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/32261fc5-87cf-490d-9e43-03cb55efa31f)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/10ffd330-81ba-4362-aaec-1f34ceaf5e86)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/11db7fe9-7389-418a-b5a0-9c628788dcff)|
|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/debb60f6-7c6f-4d04-aed7-010df77dce3c)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/24289526-df91-4a55-ba4e-f735c076cf83)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/02f7d98c-ef6d-4b06-82bc-cfe2e6b5a718)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/1c7156b4-f175-449a-9420-1b6783fd9b2b)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/16136747-1ff0-4b8d-87a7-c9d38eae25d2)|![image](https://github.com/nguyenminhhung2011/State_manage_stream/assets/90996598/fbbb1a9a-8fe3-4edd-a91f-7851801f463c)|
