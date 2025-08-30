import 'dart:math' as math;

import 'package:flutter/material.dart';

class OnboardingDogHealth extends StatefulWidget {
  const OnboardingDogHealth({super.key});
  @override
  State<OnboardingDogHealth> createState() => _OnboardingDogHealthState();
}

class _OnboardingDogHealthState extends State<OnboardingDogHealth>
    with SingleTickerProviderStateMixin {
  final _page = PageController();
  int _index = 0;

  late final AnimationController _yearsCtrl;
  late Animation<double> _yearsAnim;

  static double _clamp(double v, double min, double max) =>
      v < min ? min : (v > max ? max : v);

  @override
  void initState() {
    super.initState();
    _yearsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _yearsAnim = Tween<double>(
      begin: 8,
      end: 11,
    ).chain(CurveTween(curve: Curves.easeInOutCubic)).animate(_yearsCtrl);
  }

  @override
  void dispose() {
    _page.dispose();
    _yearsCtrl.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = _clamp((_index + delta).toDouble(), 0, 2).toInt();
    if (next != _index) {
      _page.animateToPage(
        next,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onChanged(int i) {
    setState(() => _index = i);
    if (i == 1) _yearsCtrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFFF7F7F9)],
              ),
              borderRadius: BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  Positioned(
                    top: 12,
                    left: 0,
                    right: 0,
                    child: _HeaderDots(index: _index),
                  ),
                  PageView(
                    controller: _page,
                    onPageChanged: _onChanged,
                    children: [
                      _SlideHero(onNext: () => _go(1)),
                      _SlideDemo(
                        yearsAnim: _yearsAnim,
                        onPrev: () => _go(-1),
                        onNext: () => _go(1),
                      ),
                      _SlideBenefit(onPrev: () => _go(-1)),
                    ],
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: _Footer(
                      index: _index,
                      onPrev: () => _go(-1),
                      onNext: () => _go(1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderDots extends StatelessWidget {
  final int index;
  const _HeaderDots({required this.index});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (i) => Container(
          width: 24,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: index == i ? Colors.black87 : const Color(0xFFD1D5DB),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}

class _SlideHero extends StatelessWidget {
  final VoidCallback onNext;
  const _SlideHero({required this.onNext});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFEFFDF2), Colors.white]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.95, end: 1),
                  duration: const Duration(milliseconds: 1600),
                  curve: Curves.easeInOut,
                  builder: (_, v, child) =>
                      Transform.scale(scale: v, child: child),
                  child: CustomPaint(painter: _HeartPainter()),
                ),
                const Center(child: Text('🐶', style: TextStyle(fontSize: 64))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Together for Health',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: 280,
              child: Text(
                'You are their heart, but their health is in your hands.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _PrimaryBtn(text: 'Continue', onPressed: onNext),
        ],
      ),
    );
  }
}

class _SlideDemo extends StatefulWidget {
  final Animation<double> yearsAnim;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  const _SlideDemo({
    required this.yearsAnim,
    required this.onPrev,
    required this.onNext,
  });
  @override
  State<_SlideDemo> createState() => _SlideDemoState();
}

class _SlideDemoState extends State<_SlideDemo> {
  String _choice = 'Behavior';
  double get _progress {
    final y = widget.yearsAnim.value;
    final p = (y - 6) / (14 - 6);
    return p.clamp(0, 1);
  }

  @override
  void initState() {
    super.initState();
    widget.yearsAnim.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF30D158); // your brand green
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Choose a Category',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (final t in const [
                ('Behavior', '🐾'),
                ('Activity', '🏃'),
                ('Care', '🩺'),
              ])
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: InkWell(
                      onTap: () => setState(() => _choice = t.$1),
                      borderRadius: BorderRadius.circular(16),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: _choice == t.$1
                              ? const Color(0xFFF3F4F6)
                              : const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(t.$2, style: const TextStyle(fontSize: 28)),
                            const SizedBox(height: 4),
                            Text(
                              t.$1,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(200, 200),
                  painter: _GaugePainter(
                    progress: _progress,
                    bgColor: const Color(0xFFE5E7EB),
                    gradient: const [primary, Color(0xFF14B8A6)],
                    stroke: 12,
                  ),
                ),
                Text(
                  '${widget.yearsAnim.value.toStringAsFixed(1)} Years',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'based on your ${_choice.toLowerCase()}',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _SecondaryBtn(text: 'Back', onPressed: widget.onPrev),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PrimaryBtn(text: 'Continue', onPressed: widget.onNext),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SlideBenefit extends StatelessWidget {
  final VoidCallback onPrev;
  const _SlideBenefit({required this.onPrev});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'More Time Together',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          const Text(
            '+2 years of healthy life possible*',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 18),
          Column(
            children: [
              Container(
                width: 144,
                height: 144,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF30D158), Color(0xFF14B8A6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  '+2 Years',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 96,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFC7F9D4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const SizedBox(
            width: 280,
            child: Text(
              '*Illustrative example. Results vary. No guarantee of lifespan '
              'extension is implied. DogAgePlus provides guidance and insights '
              'and does not replace veterinary care.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _SecondaryBtn(text: 'Back', onPressed: onPrev),
              ),
              const SizedBox(width: 12),
              const Expanded(child: _PrimaryBtn(text: 'Get Started')),
            ],
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final int index;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  const _Footer({
    required this.index,
    required this.onPrev,
    required this.onNext,
  });
  @override
  Widget build(BuildContext context) {
    final disabledPrev = index == 0;
    final disabledNext = index == 2;
    return Row(
      children: [
        _ChipBtn(label: 'Prev', onTap: disabledPrev ? null : onPrev),
        const SizedBox(width: 6),
        _ChipBtn(label: 'Next', onTap: disabledNext ? null : onNext),
      ],
    );
  }
}

class _ChipBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _ChipBtn({required this.label, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.3 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }
}

class _PrimaryBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const _PrimaryBtn({required this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
          shadowColor: const Color(0x33000000),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        child: Text(text),
      ),
    );
  }
}

class _SecondaryBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const _SecondaryBtn({required this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          side: const BorderSide(color: Color(0xFFE5E7EB)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        child: Text(text),
      ),
    );
  }
}

class _HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    final w = size.width, h = size.height;
    p.moveTo(w * .5, h * .8);
    p.lineTo(w * .2, h * .5);
    p.addArc(
      Rect.fromCircle(center: Offset(w * .4, h * .45), radius: h * .18),
      math.pi,
      math.pi,
    );
    p.addArc(
      Rect.fromCircle(center: Offset(w * .6, h * .45), radius: h * .18),
      math.pi,
      math.pi,
    );
    p.lineTo(w * .5, h * .8);
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFEF4444);
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GaugePainter extends CustomPainter {
  final double progress; // 0..1
  final List<Color> gradient;
  final double stroke;
  final Color bgColor;

  _GaugePainter({
    required this.progress,
    required this.gradient,
    required this.stroke,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = math.min(size.width, size.height) / 2 - stroke;
    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = bgColor
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(c, r, bg);

    final rect = Rect.fromCircle(center: c, radius: r);
    final sweep = 2 * math.pi * progress;
    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: -math.pi / 2 + sweep,
        colors: gradient,
      ).createShader(rect);
    canvas.drawArc(rect, -math.pi / 2, sweep, false, fg);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) =>
      old.progress != progress || old.gradient != gradient;
}
