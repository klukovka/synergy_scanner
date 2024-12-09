import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rxdart/rxdart.dart';

class SearchField extends StatefulWidget {
  final ValueSetter<String> search;
  final String hintText;
  final bool isLoading;

  const SearchField({
    super.key,
    required this.search,
    required this.hintText,
    required this.isLoading,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;
  late final PublishSubject<String> _subject;
  bool _isChanged = false;

  bool get _isLoading => _isChanged && widget.isLoading;

  @override
  void initState() {
    super.initState();
    _subject = PublishSubject<String>();
    _controller = TextEditingController()
      ..addListener(() => _subject.add(_controller.text));
    _subject.stream
        .debounce((_) => TimerStream(_, const Duration(seconds: 1)))
        .listen((event) {
      widget.search(event);
      setState(() {
        _isChanged = true;
      });
    });
  }

  @override
  void didUpdateWidget(covariant SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isLoading) {
      setState(() {
        _isChanged = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        prefixIcon: _isLoading
            ? const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(MdiIcons.magnify),
        prefixIconConstraints:
            const BoxConstraints.tightFor(width: 40, height: 40),
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: () => _controller.text = '',
          icon: Icon(
            MdiIcons.closeCircle,
          ),
        ),
      ),
    );
  }
}
