import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../data/mock_data.dart';
import '../components/yunnan_map.dart';
import '../widgets/heritage_image.dart';

class HomePage extends StatefulWidget {
  final Function(int) onTabChange;
  final ValueChanged<String> onSearch;

  const HomePage({super.key, required this.onTabChange, required this.onSearch});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;
  final int _autoPlayInterval = 4;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: _autoPlayInterval), (timer) {
      if (_currentPage < cultureList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _startAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(),
                _buildHomeMapSection(),
                _buildCarousel(),
                _buildQuickAccess(),
                _buildFeaturedSection(),
                _buildKnowledgeSection(),
                _buildStatsSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeMapSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 26, 20, 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFD9C09B)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.explore, color: Color(0xFF9C3F26), size: 30),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '云南非遗地域图谱',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C2418),
                        fontFamily: 'STKaiti',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('点击州市，在地图旁直接查看当地代表性非遗。'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const YunnanMapWidget(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 380,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/heritage/背景图.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color(0xCC5D3A1A), BlendMode.darken),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          gradient: LinearGradient(
            colors: [
              const Color(0x993E2723),
              const Color(0x665D3A1A),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFE4B5), width: 2),
              ),
              child: const Icon(Icons.castle, size: 56, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              '非遗文化之美',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'STKaiti',
                letterSpacing: 12,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black38,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '传承千年智慧 · 弘扬民族文化',
              style: TextStyle(
                color: Color(0xFFFFE4B5),
                fontSize: 18,
                letterSpacing: 5,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: const Color(0xFFDEB887), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: TextField(
                onSubmitted: widget.onSearch,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: '搜索非遗项目、地区或类别...',
                  border: InputBorder.none,
                  isDense: true,
                  prefixIcon: Icon(Icons.search, color: Color(0xFF8B4513)),
                  suffixIcon: Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF8B4513),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 280,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: cultureList.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return _buildCarouselItem(cultureList[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: cultureList.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Color(0xFF8B4513),
                  dotColor: Color(0xFFFFE4B5),
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 10,
                  expansionFactor: 2.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(CultureItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: heritageImageProvider(item.imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 20,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [Color(0x99000000), Color(0x33000000), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFFE4B5),
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x448B4513),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    item.level,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'STKaiti',
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: Colors.black45,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE4B5).withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Color(0xFF8B4513),
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.location,
                      style: const TextStyle(
                        color: Color(0xFFFFE4B5),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccess() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '快速导航',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D3A1A),
                  fontFamily: 'STKaiti',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) => GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: constraints.maxWidth < 520 ? 2 : 4,
              childAspectRatio: constraints.maxWidth < 520 ? 1.4 : 1,
              mainAxisSpacing: 20,
              children: [
                _buildQuickItem(Icons.collections, '非遗项目', 1),
                _buildQuickItem(Icons.person, '传承人', 2),
                _buildQuickItem(Icons.gamepad, '互动体验', 3),
                _buildQuickItem(Icons.info, '关于我们', 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => widget.onTabChange(index),
      child: Column(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF8E7), Color(0xFFF5DEB3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: const Color(0xFFDEB887), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x55DEB887),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFF8B4513), size: 40),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D3A1A),
              fontFamily: 'STKaiti',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '精选非遗',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D3A1A),
                  fontFamily: 'STKaiti',
                ),
              ),
              GestureDetector(
                onTap: () => widget.onTabChange(1),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFFE4B5),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    '查看全部',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'STKaiti',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cultureList.length,
              itemBuilder: (context, index) {
                return _buildCultureCard(cultureList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCultureCard(CultureItem item) {
    return Container(
      width: 220,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDEB887), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                image: DecorationImage(
                  image: heritageImageProvider(item.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B4513).withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFFFE4B5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        item.level,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B4513),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFFFE4B5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        item.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF5D3A1A),
                    fontFamily: 'STKaiti',
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Color(0xFF8B4513),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.location,
                      style: TextStyle(
                        fontSize: 13,
                        color: const Color(0xFF8B4513),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B4513), Color(0xFFA0522D), Color(0xFF8B4513)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFFFFE4B5), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x668B4513),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(30),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        runAlignment: WrapAlignment.center,
        spacing: 24,
        runSpacing: 20,
        children: [
          _buildStatItem('128', '非遗项目', Icons.collections),
          _buildStatItem('56', '传承人', Icons.person),
          _buildStatItem('8', '州市', Icons.map),
          _buildStatItem('26', '国家级', Icons.star),
        ],
      ),
    );
  }

  Widget _buildKnowledgeSection() {
    final topics = [
      (Icons.handyman, '传统技艺', '从材料、工具到工序，读懂手艺背后的地方智慧'),
      (Icons.music_note, '传统音乐', '在古谱、乐器与口传心授中延续民族声音'),
      (Icons.accessibility_new, '传统舞蹈', '以身体语言记录自然观察、节庆礼俗与共同记忆'),
      (Icons.theater_comedy, '传统戏剧', '唱腔、方言与舞台共同保存云南人的生活故事'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '认识云南非遗',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D3A1A),
              fontFamily: 'STKaiti',
            ),
          ),
          const SizedBox(height: 8),
          const Text('非遗不只是展品，更是仍在社区生活中不断被创造的文化实践。'),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth >= 900
                  ? (constraints.maxWidth - 48) / 4
                  : constraints.maxWidth >= 520
                  ? (constraints.maxWidth - 16) / 2
                  : constraints.maxWidth;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: topics.map((topic) {
                  return Container(
                    width: width,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE6CFAC)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x12000000),
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4E5CD),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(topic.$1, color: const Color(0xFF8B4513)),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          topic.$2,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D3A1A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(topic.$3, style: const TextStyle(height: 1.55)),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE4B5).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'STKaiti',
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFFFE4B5),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
