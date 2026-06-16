import 'package:flutter/material.dart';

class YunnanMapRegion {
  final String name;
  final List<Offset> points;
  final Offset label;

  const YunnanMapRegion(this.name, this.points, this.label);
}

class YunnanAdministrativeMap extends StatelessWidget {
  final ValueChanged<String> onRegionTap;

  const YunnanAdministrativeMap({super.key, required this.onRegionTap});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.28,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          return GestureDetector(
            onTapUp: (details) {
              for (final region in yunnanMapRegions.reversed) {
                if (_regionPath(region, size).contains(details.localPosition)) {
                  onRegionTap(region.name);
                  return;
                }
              }
            },
            child: CustomPaint(
              size: size,
              painter: _YunnanAdministrativePainter(),
            ),
          );
        },
      ),
    );
  }
}

Path _regionPath(YunnanMapRegion region, Size size) {
  final path = Path();
  for (var i = 0; i < region.points.length; i++) {
    final point = region.points[i];
    final scaled = Offset(point.dx * size.width, point.dy * size.height);
    i == 0
        ? path.moveTo(scaled.dx, scaled.dy)
        : path.lineTo(scaled.dx, scaled.dy);
  }
  return path..close();
}

class _YunnanAdministrativePainter extends CustomPainter {
  static const colors = [
    Color(0xFF8FCBD6),
    Color(0xFF74B9CB),
    Color(0xFFA7D7DE),
    Color(0xFF65AFC3),
    Color(0xFFB5DEE1),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final unionPath = Path();
    for (final region in yunnanMapRegions) {
      unionPath.addPath(_regionPath(region, size), Offset.zero);
    }
    canvas.save();
    canvas.translate(0, 7);
    canvas.drawPath(
      unionPath,
      Paint()
        ..color = const Color(0x260C5B70)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );
    canvas.restore();

    for (var index = 0; index < yunnanMapRegions.length; index++) {
      final region = yunnanMapRegions[index];
      final path = _regionPath(region, size);
      canvas.drawPath(path, Paint()..color = colors[index % colors.length]);
      canvas.drawPath(
        path,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width < 600 ? 1.4 : 2.2
          ..strokeJoin = StrokeJoin.round,
      );
      final painter = TextPainter(
        text: TextSpan(
          text: region.name,
          style: TextStyle(
            color: const Color(0xFF174F63),
            fontSize: size.width < 600 ? 9 : 13,
            fontWeight: FontWeight.w600,
            shadows: const [Shadow(color: Colors.white, blurRadius: 3)],
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width * .15);
      painter.paint(
        canvas,
        Offset(
          region.label.dx * size.width - painter.width / 2,
          region.label.dy * size.height - painter.height / 2,
        ),
      );
    }
    canvas.drawPath(
      unionPath,
      Paint()
        ..color = const Color(0xFF21758B)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width < 600 ? 2 : 3
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

const yunnanMapRegions = <YunnanMapRegion>[
  YunnanMapRegion('迪庆', [
    Offset(.28, .04),
    Offset(.37, .07),
    Offset(.39, .18),
    Offset(.34, .25),
    Offset(.25, .20),
    Offset(.22, .11),
  ], Offset(.30, .13)),
  YunnanMapRegion('怒江', [
    Offset(.22, .11),
    Offset(.25, .20),
    Offset(.27, .36),
    Offset(.22, .50),
    Offset(.15, .43),
    Offset(.13, .28),
  ], Offset(.20, .31)),
  YunnanMapRegion('丽江', [
    Offset(.25, .20),
    Offset(.34, .25),
    Offset(.42, .22),
    Offset(.45, .34),
    Offset(.36, .41),
    Offset(.27, .36),
  ], Offset(.35, .31)),
  YunnanMapRegion('大理', [
    Offset(.27, .36),
    Offset(.36, .41),
    Offset(.39, .54),
    Offset(.32, .65),
    Offset(.22, .61),
    Offset(.22, .50),
  ], Offset(.31, .50)),
  YunnanMapRegion('保山', [
    Offset(.15, .43),
    Offset(.22, .50),
    Offset(.22, .61),
    Offset(.16, .69),
    Offset(.08, .60),
    Offset(.07, .48),
  ], Offset(.15, .56)),
  YunnanMapRegion('德宏', [
    Offset(.08, .60),
    Offset(.16, .69),
    Offset(.18, .79),
    Offset(.10, .83),
    Offset(.04, .72),
  ], Offset(.11, .72)),
  YunnanMapRegion('临沧', [
    Offset(.16, .69),
    Offset(.22, .61),
    Offset(.32, .65),
    Offset(.35, .78),
    Offset(.28, .88),
    Offset(.18, .79),
  ], Offset(.26, .74)),
  YunnanMapRegion('普洱', [
    Offset(.32, .65),
    Offset(.39, .54),
    Offset(.49, .61),
    Offset(.53, .76),
    Offset(.48, .91),
    Offset(.36, .95),
    Offset(.28, .88),
    Offset(.35, .78),
  ], Offset(.42, .75)),
  YunnanMapRegion('西双版纳', [
    Offset(.48, .91),
    Offset(.53, .76),
    Offset(.61, .82),
    Offset(.64, .94),
    Offset(.58, .99),
  ], Offset(.56, .91)),
  YunnanMapRegion('楚雄', [
    Offset(.36, .41),
    Offset(.45, .34),
    Offset(.55, .39),
    Offset(.58, .52),
    Offset(.49, .61),
    Offset(.39, .54),
  ], Offset(.48, .47)),
  YunnanMapRegion('昆明', [
    Offset(.42, .22),
    Offset(.55, .19),
    Offset(.64, .25),
    Offset(.63, .39),
    Offset(.55, .39),
    Offset(.45, .34),
  ], Offset(.55, .29)),
  YunnanMapRegion('曲靖', [
    Offset(.55, .19),
    Offset(.63, .12),
    Offset(.76, .18),
    Offset(.86, .29),
    Offset(.82, .40),
    Offset(.70, .42),
    Offset(.63, .39),
    Offset(.64, .25),
  ], Offset(.72, .29)),
  YunnanMapRegion('昭通', [
    Offset(.37, .07),
    Offset(.50, .10),
    Offset(.63, .12),
    Offset(.55, .19),
    Offset(.42, .22),
    Offset(.39, .18),
  ], Offset(.48, .14)),
  YunnanMapRegion('玉溪', [
    Offset(.55, .39),
    Offset(.63, .39),
    Offset(.70, .42),
    Offset(.69, .55),
    Offset(.58, .52),
  ], Offset(.63, .47)),
  YunnanMapRegion('红河', [
    Offset(.58, .52),
    Offset(.69, .55),
    Offset(.80, .54),
    Offset(.84, .69),
    Offset(.72, .78),
    Offset(.61, .82),
    Offset(.53, .76),
    Offset(.49, .61),
  ], Offset(.67, .66)),
  YunnanMapRegion('文山', [
    Offset(.70, .42),
    Offset(.82, .40),
    Offset(.93, .49),
    Offset(.96, .62),
    Offset(.88, .72),
    Offset(.84, .69),
    Offset(.80, .54),
    Offset(.69, .55),
  ], Offset(.84, .57)),
];
