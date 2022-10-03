



## Features

This Package format textinput when you want to add Pattern format money in Device.
A few devices have comma instead of dot. But we are fixed it for you.

## Getting started
flutter pub add textfield_pattern_formatter


## How to use

```dart
Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
TextField(
inputFormatters: [ThousandSeparatorDecimalFormatter()],
)
],
),
```

## Additional information

You can also use this repo as a template for creating Dart packages, just clone the repo and start hacking :)
