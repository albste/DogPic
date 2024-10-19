# DogPic

A Flutter application that shows the result of Api calls to get images of dogs.

## Prerequisites

Before you begin, ensure you have met the following requirements:

### Flutter SDK

You need to have Flutter installed on your machine. You can download and install it by following the official [Flutter installation guide](https://docs.flutter.dev/get-started/install).

- **Recommended Flutter version**: `>= 3.0.0`

### Dart SDK

The Dart SDK comes with Flutter, but ensure you're using the correct version. You can check your Dart version by running:

```bash
  dart --version
```

## Cloning and Running the Application in local

Clone the project into local

Install dependencies. Run the following command to install all necessary Flutter dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## API

-The implemented API are:

**'https://dog.ceo/api/breeds/list/all'**
Get all breeds and subbreeds

**'https://dog.ceo/api/breed/$breedName/images/random'**
Get random image by breed

**'https://dog.ceo/api/breed/$breedName/images'**
Get images list by breed

**'https://dog.ceo/api/breed/$breedName/$subBreedName/images/random'**
Get random image by breed and sub breed

**'https://dog.ceo/api/breed/$breedName/$subBreedName/images'**
Get images list by breed and sub breed

## API Documentation

https://dog.ceo/dog-api/documentation/

## Markup

You can find the project markup in the DogPic_Markup.svg file in the root of the project. During the development phase some components have changed and differ from how they were initially in the markup.
