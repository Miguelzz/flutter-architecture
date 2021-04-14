import 'package:flutter/material.dart';

class Item<T> {
  final String text;
  final T value;

  Item({required this.text, required this.value});
}

class SelectBasic<T> extends StatefulWidget {
  final List<Item<T>> list;
  final ValueChanged<T?>? onChanged;
  SelectBasic({required this.list, required this.onChanged});

  @override
  _SelectState<T> createState() => _SelectState<T>();
}

class _SelectState<T> extends State<SelectBasic<T>> {
  T? _selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: _selected,
      hint: Text('Select...'),
      items: widget.list.map((item) {
        return DropdownMenuItem<T>(
          value: item.value,
          child: Text(item.text),
        );
      }).toList(),
      onChanged: widget.onChanged == null
          ? null
          : (value) {
              setState(() {
                _selected = value;
                widget.onChanged!(value);
              });
            },
    );
  }
}
