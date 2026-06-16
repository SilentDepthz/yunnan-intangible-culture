import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/mock_data.dart';
import '../widgets/yunnan_administrative_map.dart';

class MapPrefecture {
  final String name;
  final List<List<Offset>> polygons;

  const MapPrefecture({required this.name, required this.polygons});
}

class YunnanMapWidget extends StatefulWidget {
  const YunnanMapWidget({super.key});

  @override
  State<YunnanMapWidget> createState() => _YunnanMapWidgetState();
}

class _YunnanMapWidgetState extends State<YunnanMapWidget> {
  List<MapPrefecture> _prefectures = [];
  RegionInfo? _selectedRegion;
  bool _isLoading = true;
  bool _usingFallback = false;

  @override
  void initState() {
    super.initState();
    _selectedRegion = yunnanRegions.first;
    _fetchMapData();
  }

  Future<void> _fetchMapData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://geo.datav.aliyun.com/areas_v3/bound/530000_full.json',
        ),
      );
      if (response.statusCode != 200) throw Exception('地图数据请求失败');
      final parsed = _parseGeoJson(jsonDecode(response.body));
      if (parsed.isEmpty) throw Exception('地图数据为空');
      if (!mounted) return;
      setState(() {
        _prefectures = parsed;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _usingFallback = true;
        _isLoading = false;
      });
    }
  }

  List<MapPrefecture> _parseGeoJson(dynamic data) {
    final result = <MapPrefecture>[];
    final features = data is Map<String, dynamic> ? data['features'] : null;
    if (features is! List) return result;

    for (final feature in features) {
      if (feature is! Map) continue;
      final properties = feature['properties'];
      final geometry = feature['geometry'];
      if (properties is! Map || geometry is! Map) continue;
      final name = '${properties['name'] ?? ''}'
          .replaceAll('市', '')
          .replaceAll('自治州', '');
      final coordinates = geometry['coordinates'];
      final type = geometry['type'];
      final polygons = <List<Offset>>[];

      if (type == 'Polygon' && coordinates is List) {
        _appendPolygon(coordinates, polygons);
      } else if (type == 'MultiPolygon' && coordinates is List) {
        for (final polygon in coordinates) {
          if (polygon is List) _appendPolygon(polygon, polygons);
        }
      }
      if (name.isNotEmpty && polygons.isNotEmpty) {
        result.add(MapPrefecture(name: name, polygons: polygons));
      }
    }
    return result;
  }

  void _appendPolygon(dynamic rings, List<List<Offset>> target) {
    if (rings is! List || rings.isEmpty || rings.first is! List) return;
    final points = <Offset>[];
    for (final point in rings.first as List) {
      if (point is List && point.length >= 2) {
        final longitude = point[0];
        final latitude = point[1];
        if (longitude is num && latitude is num) {
          points.add(Offset(longitude.toDouble(), latitude.toDouble()));
        }
      }
    }
    if (points.length >= 3) target.add(points);
  }

  void _selectByName(String rawName) {
    final normalized = rawName
        .replaceAll('市', '')
        .replaceAll('自治州', '')
        .replaceAll('地区', '');
    final region = yunnanRegions.cast<RegionInfo?>().firstWhere(
      (item) =>
          normalized.contains(item!.name) || item.name.contains(normalized),
      orElse: () => null,
    );
    setState(() {
      _selectedRegion =
          region ??
          RegionInfo(
            name: normalized,
            count: 0,
            description: '$normalized拥有多民族交往交流形成的文化生态，相关非遗档案正在持续整理与补充。',
            famousItems: const ['民间文学', '传统音乐', '传统技艺', '节庆民俗'],
            x: 0,
            y: 0,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 840;
        final map = _buildMapPanel();
        final detail = _buildRegionPanel();
        return isWide
            ? SizedBox(
                height: 500,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex: 3, child: map),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: detail),
                  ],
                ),
              )
            : Column(children: [map, const SizedBox(height: 16), detail]);
      },
    );
  }

  Widget _buildMapPanel() {
    return SizedBox(
      height: 500,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F4EA),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFD9C09B)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.map_outlined, color: Color(0xFF8A3D22)),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '云南非遗地域图谱',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                if (_usingFallback)
                  const Text('离线地图', style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 4),
            const Text('点击地图中的州市，右侧将展示当地代表性非遗。'),
            const SizedBox(height: 14),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _usingFallback
                  ? YunnanAdministrativeMap(onRegionTap: _selectByName)
                  : _GeoPrefectureMap(
                      prefectures: _prefectures,
                      selectedName: _selectedRegion?.name,
                      onSelected: _selectByName,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionPanel() {
    final region = _selectedRegion!;
    final related = cultureList.where((item) {
      return item.location.contains(region.name) ||
          region.famousItems.any((name) => item.name.contains(name));
    }).toList();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 260),
      child: Container(
        key: ValueKey(region.name),
        constraints: const BoxConstraints(minHeight: 430),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4C2418), Color(0xFF873B22)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 24,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                region.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'STKaiti',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                region.count > 0 ? '收录 ${region.count} 项代表性非遗' : '区域档案持续建设中',
                style: const TextStyle(color: Color(0xFFFFD9A0)),
              ),
              const SizedBox(height: 20),
              Text(
                region.description,
                style: const TextStyle(color: Colors.white, height: 1.75),
              ),
              const SizedBox(height: 22),
              const Text(
                '代表性项目',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: region.famousItems.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
              if (related.isNotEmpty) ...[
                const SizedBox(height: 22),
                const Text(
                  '平台专题',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...related
                    .take(2)
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.auto_awesome,
                              color: Color(0xFFFFD9A0),
                              size: 17,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${item.name} · ${item.category}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _GeoPrefectureMap extends StatefulWidget {
  final List<MapPrefecture> prefectures;
  final String? selectedName;
  final ValueChanged<String> onSelected;

  const _GeoPrefectureMap({
    required this.prefectures,
    required this.selectedName,
    required this.onSelected,
  });

  @override
  State<_GeoPrefectureMap> createState() => _GeoPrefectureMapState();
}

class _GeoPrefectureMapState extends State<_GeoPrefectureMap> {
  List<_RenderedPrefecture> _rendered = const [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _rendered = _projectPrefectures(widget.prefectures, size);
        return GestureDetector(
          onTapUp: (details) {
            for (final region in _rendered.reversed) {
              if (region.paths.any(
                (path) => path.contains(details.localPosition),
              )) {
                widget.onSelected(region.name);
                break;
              }
            }
          },
          child: CustomPaint(
            size: size,
            painter: _GeoMapPainter(_rendered, widget.selectedName),
          ),
        );
      },
    );
  }
}

class _RenderedPrefecture {
  final String name;
  final List<Path> paths;
  final Offset label;

  const _RenderedPrefecture(this.name, this.paths, this.label);
}

List<_RenderedPrefecture> _projectPrefectures(
  List<MapPrefecture> prefectures,
  Size size,
) {
  var minX = double.infinity;
  var maxX = double.negativeInfinity;
  var minY = double.infinity;
  var maxY = double.negativeInfinity;
  for (final region in prefectures) {
    for (final polygon in region.polygons) {
      for (final point in polygon) {
        minX = math.min(minX, point.dx);
        maxX = math.max(maxX, point.dx);
        minY = math.min(minY, point.dy);
        maxY = math.max(maxY, point.dy);
      }
    }
  }
  final scale = math.min(
    size.width * .9 / (maxX - minX),
    size.height * .88 / (maxY - minY),
  );
  final mapWidth = (maxX - minX) * scale;
  final mapHeight = (maxY - minY) * scale;
  final offsetX = (size.width - mapWidth) / 2;
  final offsetY = (size.height - mapHeight) / 2;

  Offset project(Offset point) => Offset(
    offsetX + (point.dx - minX) * scale,
    offsetY + (maxY - point.dy) * scale,
  );

  return prefectures.map((region) {
    final paths = <Path>[];
    var totalX = 0.0;
    var totalY = 0.0;
    var count = 0;
    for (final polygon in region.polygons) {
      final path = Path();
      for (var index = 0; index < polygon.length; index++) {
        final point = project(polygon[index]);
        index == 0
            ? path.moveTo(point.dx, point.dy)
            : path.lineTo(point.dx, point.dy);
        totalX += point.dx;
        totalY += point.dy;
        count++;
      }
      paths.add(path..close());
    }
    return _RenderedPrefecture(
      region.name,
      paths,
      Offset(totalX / count, totalY / count),
    );
  }).toList();
}

class _GeoMapPainter extends CustomPainter {
  final List<_RenderedPrefecture> prefectures;
  final String? selectedName;

  const _GeoMapPainter(this.prefectures, this.selectedName);

  @override
  void paint(Canvas canvas, Size size) {
    const palette = [
      Color(0xFF8CC7BD),
      Color(0xFFB7D9C8),
      Color(0xFFE2C48E),
      Color(0xFFD99B73),
      Color(0xFF7DB2B4),
    ];
    for (var index = 0; index < prefectures.length; index++) {
      final region = prefectures[index];
      final selected =
          selectedName != null && region.name.contains(selectedName!);
      for (final path in region.paths) {
        canvas.drawPath(
          path,
          Paint()
            ..color = selected
                ? const Color(0xFFB7472A)
                : palette[index % palette.length],
        );
        canvas.drawPath(
          path,
          Paint()
            ..color = const Color(0xFFFFFCF5)
            ..style = PaintingStyle.stroke
            ..strokeWidth = selected ? 3 : 1.5,
        );
      }
      final label = TextPainter(
        text: TextSpan(
          text: region.name,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF3F3228),
            fontSize: size.width < 560 ? 9 : 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(
        canvas,
        region.label - Offset(label.width / 2, label.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GeoMapPainter oldDelegate) =>
      oldDelegate.selectedName != selectedName ||
      oldDelegate.prefectures != prefectures;
}
