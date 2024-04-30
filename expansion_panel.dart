
class ExpansionPanel extends StatefulWidget {
  final Widget header;
  final Widget body;
  final bool isExpanded;

  const ExpansionPanel({
    super.key,
    required this.header,
    required this.body,
    this.isExpanded = true,
  });

  @override
  _ExpansionPanelState createState() => _ExpansionPanelState();
}

class _ExpansionPanelState extends State<ExpansionPanel> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 50), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    if (widget.isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant ExpansionPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (_controller.isDismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
          child: widget.header,
        ),
        SizeTransition(
          sizeFactor: _animation,
          axisAlignment: -1,
          child: widget.body,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
