library custom_rating_bar;

import 'package:flutter/material.dart';

/// Creates rating bar.
///
/// The [onRatingChanged], [filledIcon] & [emptyIcon] must not be null.
class RatingBar extends StatefulWidget {
  RatingBar({
    Key key,
    @required this.onRatingChanged,
    @required this.filledIcon,
    @required this.emptyIcon,
    this.initialRating = 0.0,
    this.maxRating = 5,
    this.halfFilledIcon,
    this.isHalfAllowed = false,
    this.alignment = Alignment.centerLeft,
    this.direction = Axis.horizontal,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
    this.halfFilledColor = Colors.amber,
    this.size = 32,
  })  : _readOnly = false,
        assert(onRatingChanged != null, 'onRatingChanged cannot be null'),
        assert(filledIcon != null, 'filledIcon cannot be null'),
        assert(emptyIcon != null, 'emptyIcon cannot be null'),
        assert(initialRating != null, 'initialRating cannot be null'),
        assert(maxRating != null, 'maxRating cannot be null'),
        assert(isHalfAllowed != null, 'isHalfAllowed cannot be null'),
        assert(
          !isHalfAllowed || halfFilledIcon != null,
          'Unless isHalfAllowed is false, provide halfFilledIcon',
        ),
        assert(alignment != null, 'alignment cannot be null'),
        assert(direction != null, 'direction cannot be null'),
        assert(filledColor != null, 'filledColor cannot be null'),
        assert(emptyColor != null, 'emptyColor cannot be null'),
        assert(
          !isHalfAllowed || halfFilledColor != null,
          'Unless isHalfAllowed is false, provide halfFilledColor',
        ),
        assert(size != null, 'size cannot be null'),
        super(key: key);

  /// Creates read only rating bar.
  ///
  /// The [filledIcon] & [emptyIcon] must not be null.
  RatingBar.readOnly({
    Key key,
    @required this.filledIcon,
    @required this.emptyIcon,
    this.maxRating = 5,
    this.halfFilledIcon,
    this.isHalfAllowed = false,
    this.alignment = Alignment.centerLeft,
    this.direction = Axis.horizontal,
    this.initialRating = 0.0,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
    this.halfFilledColor = Colors.amber,
    this.size = 32,
  })  : _readOnly = true,
        onRatingChanged = null,
        assert(filledIcon != null, 'filledIcon cannot be null'),
        assert(emptyIcon != null, 'emptyIcon cannot be null'),
        assert(initialRating != null, 'initialRating cannot be null'),
        assert(maxRating != null, 'maxRating cannot be null'),
        assert(isHalfAllowed != null, 'isHalfAllowed cannot be null'),
        assert(
          !isHalfAllowed || halfFilledIcon != null,
          'Unless isHalfAllowed is false, provide halfFilledIcon',
        ),
        assert(alignment != null, 'alignment cannot be null'),
        assert(direction != null, 'direction cannot be null'),
        assert(filledColor != null, 'filledColor cannot be null'),
        assert(emptyColor != null, 'emptyColor cannot be null'),
        assert(
          !isHalfAllowed || halfFilledColor != null,
          'Unless isHalfAllowed is false, provide halfFilledColor',
        ),
        assert(size != null, 'size cannot be null'),
        super(key: key);

  final IconData filledIcon;
  final IconData emptyIcon;
  final int maxRating;
  final IconData halfFilledIcon;
  final void Function(double) onRatingChanged;
  final double initialRating;
  final Color filledColor;
  final Color emptyColor;
  final Color halfFilledColor;
  final bool isHalfAllowed;
  final Alignment alignment;
  final Axis direction;
  final double size;
  final bool _readOnly;

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double _currentRating;

  @override
  void initState() {
    super.initState();
    if (widget.isHalfAllowed) {
      _currentRating = widget.initialRating;
    } else {
      _currentRating = widget.initialRating.roundToDouble();
    }
  }

  @override
  Widget build(BuildContext context) => _buildRatingBar();

  Widget _buildRatingBar() => Align(
        alignment: widget.alignment,
        child: _buildDirectionWrapper(
          children: List.generate(widget.maxRating, (index) {
            final iconPosition = index + 1;
            return _buildIcon(iconPosition);
          }),
        ),
      );

  Widget _buildDirectionWrapper({List<Widget> children}) {
    if (widget.direction == Axis.vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildIcon(int position) {
    if (widget._readOnly) return _buildIconView(position);

    return GestureDetector(
      child: _buildIconView(position),
      onTap: () {
        setState(() => _currentRating = position.toDouble());
        widget.onRatingChanged(_currentRating);
      },
    );
  }

  Widget _buildIconView(int position) {
    IconData _iconData;
    Color _color;
    double _rating;
    if (widget._readOnly) {
      if (widget.isHalfAllowed) {
        _rating = widget.initialRating;
      } else {
        _rating = widget.initialRating.roundToDouble();
      }
    } else {
      _rating = _currentRating;
    }
    if (position > _rating + 0.5) {
      _iconData = widget.emptyIcon;
      _color = widget.emptyColor;
    } else if (position == _rating + 0.5) {
      _iconData = widget.halfFilledIcon;
      _color = widget.halfFilledColor;
    } else {
      _iconData = widget.filledIcon;
      _color = widget.filledColor;
    }
    return Icon(_iconData, color: _color, size: widget.size);
  }
}
