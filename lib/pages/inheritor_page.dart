import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/heritage_image.dart';

class InheritorPage extends StatefulWidget {
  const InheritorPage({super.key});

  @override
  State<InheritorPage> createState() => _InheritorPageState();
}

class _InheritorPageState extends State<InheritorPage> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('传承人与故事'),
        backgroundColor: const Color(0xFF8B4513),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'STKaiti',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: selectedTab == 0
                ? _buildInheritorList()
                : _buildStoryTimeline(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [_buildTab('传承人', 0), _buildTab('非遗故事', 1)]),
    );
  }

  Widget _buildTab(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selectedTab == index
                    ? const Color(0xFF8B4513)
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: selectedTab == index
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: selectedTab == index
                  ? const Color(0xFF8B4513)
                  : Colors.grey[600],
              fontSize: 16,
              fontFamily: 'STKaiti',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInheritorList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: inheritorList.length,
      itemBuilder: (context, index) {
        return _buildInheritorCard(inheritorList[index]);
      },
    );
  }

  Widget _buildInheritorCard(Inheritor item) {
    return InkWell(
      onTap: () => _showInheritorDetail(item),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFDEB887), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: heritageImage(
                item.avatar,
                width: 130,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D3A1A),
                            fontFamily: 'STKaiti',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E7),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFDEB887),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              color: Color(0xFF8B4513),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '传承项目: ${item.cultureName}',
                      style: TextStyle(
                        fontSize: 13,
                        color: const Color(0xFF8B4513),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: item.achievements
                          .take(2)
                          .map((achievement) => _buildAchievement(achievement))
                          .toList(),
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '查看完整档案',
                          style: TextStyle(color: Color(0xFF8B4513)),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Color(0xFF8B4513),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievement(String achievement) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF8B4513), size: 14),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              achievement,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  void _showInheritorDetail(Inheritor item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: .78,
        minChildSize: .55,
        maxChildSize: .92,
        builder: (context, controller) => Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
          decoration: const BoxDecoration(
            color: Color(0xFFFFFCF5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: ListView(
            controller: controller,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD0B99A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: heritageImage(
                  item.avatar,
                  height: 240,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C2418),
                  fontFamily: 'STKaiti',
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text(item.cultureName)),
                  Chip(label: Text(item.title)),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                item.description,
                style: const TextStyle(fontSize: 16, height: 1.75),
              ),
              const SizedBox(height: 22),
              const Text(
                '传承实践',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...item.achievements.map(_buildAchievement),
              if (item.title == '教学情境创作') ...[
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0D9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    '说明：该人物为教学展示而创作，内容参考相应非遗项目的常见传承实践，不对应具体真实人物。',
                    style: TextStyle(height: 1.6),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryTimeline() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: storyList.length,
      itemBuilder: (context, index) {
        return _buildTimelineItem(storyList[index], index);
      },
    );
  }

  Widget _buildTimelineItem(Story item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B4513), Color(0xFFA0522D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFFE4B5), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x448B4513),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.book, color: Colors.white, size: 14),
          ),
          Container(
            width: 3,
            height: 140,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8B4513), Color(0xFFDEB887)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFDEB887), width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: heritageImage(
                      item.imageUrl,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5D3A1A),
                                fontFamily: 'STKaiti',
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (item.title.startsWith('创作故事'))
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE7C2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  '教学情境创作 · 非真实事件记录',
                                  style: TextStyle(
                                    color: Color(0xFF8B4513),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            Text(
                              '${item.date.year}年${item.date.month}月${item.date.day}日',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.content,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
