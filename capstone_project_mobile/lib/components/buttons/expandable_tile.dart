import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ExpandableTile extends StatefulWidget {
  final String title;
  final String? text1;
  final String? text2;
  final String? text3;

  const ExpandableTile({
    super.key,
    required this.title,
    this.text1,
    this.text2,
    this.text3,
  });

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.7,
                child: Text(
                  widget.title,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                _isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                color: Colors.white,
              ),
            ],
          ),
          if (_isExpanded) ...[
            const SizedBox(height: 20),
            if (widget.text1 != null) ...[
              Text(
                widget.text1!,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
            ],
            if (widget.text2 != null) ...[
              Text(
                widget.text2!,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
            ],
            if (widget.text3 != null) ...[
              Text(
                widget.text3!,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ],
      ),
    );
  }
}
