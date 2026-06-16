import 'package:flutter/material.dart';
import '../components/yunnan_map.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于我们'),
        backgroundColor: const Color(0xFF8B4513),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'STKaiti',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Column(
              children: [
                _buildHeroSection(),
                _buildMapSection(context),
                _buildIntroduction(),
                _buildContact(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/heritage/背景2.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: const Color(0xFF3E2723).withOpacity(0.65),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '云南非遗文化数字展示平台',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'STKaiti',
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 8.0,
                      color: Colors.black45,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '传承千年智慧，弘扬民族文化',
                style: TextStyle(
                  color: Color(0xFFFFE4B5),
                  fontSize: 16,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black45,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '项目简介',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D3A1A),
              fontFamily: 'STKaiti',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '云南非遗文化数字展示平台旨在通过数字化手段，展示云南丰富的非物质文化遗产资源，让更多人了解和认识云南各民族的优秀传统文化。',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.7,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '平台收录了云南省内各级非遗项目，包括传统技艺、传统音乐、传统舞蹈、传统戏剧等多个类别，展示了非遗传承人的风采和非遗故事，为非遗文化的保护和传承做出贡献。',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),
          _buildFeatureCards(),
        ],
      ),
    );
  }

  Widget _buildFeatureCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth >= 760
            ? (constraints.maxWidth - 32) / 3
            : constraints.maxWidth;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildFeatureCard(
              Icons.collections_bookmark,
              '非遗档案',
              '16项深度专题',
              width,
            ),
            _buildFeatureCard(Icons.diversity_3, '活态传承', '人物、社区与故事', width),
            _buildFeatureCard(Icons.map, '地域图谱', '覆盖云南16个州市', width),
          ],
        );
      },
    );
  }

  Widget _buildFeatureCard(
    IconData icon,
    String title,
    String subtitle,
    double width,
  ) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFF8E7), Color(0xFFF5DEB3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDEB887), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x44DEB887),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF8B4513), size: 36),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF5D3A1A),
                fontFamily: 'STKaiti',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: const Color(0xFF8B4513)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 42, 24, 36),
      decoration: const BoxDecoration(
        color: Color(0xFFF4EBDD),
        image: DecorationImage(
          image: AssetImage('assets/images/heritage/tie_dye.png'),
          fit: BoxFit.cover,
          opacity: .035,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '一图读懂云南非遗',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D3A1A),
              fontFamily: 'STKaiti',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '沿着山川与古道，点击州市探索当地代表性非遗。',
            style: TextStyle(fontSize: 14, color: const Color(0xFF757575)),
          ),
          const SizedBox(height: 24),
          const YunnanMapWidget(),
        ],
      ),
    );
  }

  Widget _buildContact() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '联系我们',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D3A1A),
              fontFamily: 'STKaiti',
            ),
          ),
          const SizedBox(height: 16),
          _buildContactItem(Icons.email, '电子邮箱', 'wobugaosunihhhhh@qq.com'),
          _buildContactItem(Icons.phone, '联系电话', '0871-12345678'),
          _buildContactItem(Icons.location_on, '地址', '云南大学呈贡校区嘿嘿嘿'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDEB887), width: 1),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF8B4513), size: 22),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5D3A1A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5D3A1A), Color(0xFF3E2723)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            '云南非遗文化数字展示平台',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'STKaiti',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '传承千年智慧，弘扬民族文化',
            style: TextStyle(
              color: const Color(0xFFFFE4B5),
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey[600], thickness: 1),
          const SizedBox(height: 16),
          Text(
            'Copyright 2024 All Rights Reserved',
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
