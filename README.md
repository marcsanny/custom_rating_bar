# rating_bar

Custom rating bar for flutter with support of: custom icons, half icons, directions, alignments & more.

## Getting Started

### Instalation

Add this to your pubspec.yaml file:

```yaml
dependencies:
 custom_rating_bar: ^1.0.0
```

### How to use

```dart
import 'package:custom_rating_bar/custom_rating_bar.dart';
```

Basic widget

```dart
RatingBar(
  filledIcon: Icons.star, 
  emptyIcon: Icons.star_border,
  onRatingChanged: (value) => debugPrint('$value'),
  initialRating: 3,
  maxRating: 5,
)
```

Read only widget

```dart
RatingBar.readOnly(
  filledIcon: Icons.star, 
  emptyIcon: Icons.star_border,
  initialRating: 4,
  maxRating: 5,
)
```

### Examples

![Alt text](/examples.png?raw=true)
