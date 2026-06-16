import 'dart:math';

import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/heritage_image.dart';

class InteractivePage extends StatefulWidget {
  const InteractivePage({super.key});

  @override
  State<InteractivePage> createState() => _InteractivePageState();
}

class _InteractivePageState extends State<InteractivePage> {
  String? currentGame;
  int score = 0;
  int currentQuestionIndex = 0;
  int selectedAnswerIndex = -1;
  bool showResult = false;

  // Puzzle variables
  List<int> puzzlePositions = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  bool puzzleComplete = false;
  int moves = 0;
  int puzzleLevel = 0;
  bool showPuzzlePreview = false;
  int puzzleStars = 0;

  // Match variables
  List<MatchPair> matchCards = [];
  MatchPair? firstCard;
  MatchPair? secondCard;
  int matchedPairs = 0;
  bool isChecking = false;
  int matchAttempts = 0;
  int matchCombo = 0;
  int bestMatchCombo = 0;

  // Riddle variables
  int currentRiddleIndex = 0;
  String userAnswer = '';
  bool riddleResult = false;
  bool riddleCorrect = false;

  // Workshop variables
  int processItemIndex = 0;
  List<String> processSteps = [];
  bool processChecked = false;
  bool processCorrect = false;
  int processHints = 2;
  int processCombo = 0;
  final List<int> processChallengeIndices = [0, 2, 5, 6, 14];

  // Journey variables
  int journeyIndex = 0;
  String? journeyChoice;
  bool journeyChecked = false;
  List<String> journeyRewards = [];
  int journeyLives = 3;
  int journeyCombo = 0;

  @override
  void initState() {
    super.initState();
    initMatchGame();
    shufflePuzzle();
    _resetProcessGame();
  }

  void _resetProcessGame() {
    processItemIndex = 0;
    processSteps = List<String>.from(
      cultureList[processChallengeIndices[processItemIndex]].process,
    )
      ..shuffle();
    if (processSteps.join() ==
        cultureList[processChallengeIndices[processItemIndex]].process.join()) {
      processSteps = processSteps.reversed.toList();
    }
    processChecked = false;
    processCorrect = false;
    processHints = 2;
    processCombo = 0;
  }

  void _checkProcessOrder() {
    final answer = cultureList[processChallengeIndices[processItemIndex]].process;
    setState(() {
      processChecked = true;
      processCorrect = processSteps.join('|') == answer.join('|');
      if (processCorrect) {
        processCombo++;
        score += 12 + processCombo * 3 + processHints * 2;
      } else {
        processCombo = 0;
      }
    });
  }

  void _nextProcessChallenge() {
    if (processItemIndex >= processChallengeIndices.length - 1) {
      _showFinalResult();
      return;
    }
    setState(() {
      processItemIndex++;
      processSteps = List<String>.from(
        cultureList[processChallengeIndices[processItemIndex]].process,
      )
        ..shuffle();
      processChecked = false;
      processCorrect = false;
      processHints = 2;
    });
  }

  void _useProcessHint() {
    if (processHints <= 0 || processChecked) return;
    final answer = cultureList[processChallengeIndices[processItemIndex]].process;
    final wrongIndex = List.generate(
      processSteps.length,
      (index) => index,
    ).firstWhere(
      (index) => processSteps[index] != answer[index],
      orElse: () => -1,
    );
    if (wrongIndex < 0) return;
    final targetIndex = processSteps.indexOf(answer[wrongIndex]);
    setState(() {
      final step = processSteps.removeAt(targetIndex);
      processSteps.insert(wrongIndex, step);
      processHints--;
    });
  }

  void _retryProcessChallenge() {
    setState(() {
      processChecked = false;
      processCorrect = false;
    });
  }

  void _checkJourneyAnswer(String choice) {
    if (journeyChecked) return;
    final challenge = journeyChallenges[journeyIndex];
    setState(() {
      journeyChoice = choice;
      journeyChecked = true;
      if (choice == challenge['answer']) {
        journeyCombo++;
        score += 8 + journeyCombo * 2;
        journeyRewards.add(challenge['reward'] as String);
      } else {
        journeyLives--;
        journeyCombo = 0;
      }
    });
  }

  void _nextJourneyStop() {
    if (journeyIndex >= journeyChallenges.length - 1 || journeyLives <= 0) {
      _showFinalResult();
      return;
    }
    setState(() {
      journeyIndex++;
      journeyChoice = null;
      journeyChecked = false;
    });
  }

  void initMatchGame() {
    matchCards = List.from(matchPairs);
    matchCards.shuffle();
    matchCards = matchCards
        .map(
          (pair) => MatchPair(
            id: pair.id,
            name: pair.name,
            imageUrl: pair.imageUrl,
            isMatched: false,
            isFlipped: false,
          ),
        )
        .toList();
  }

  void shufflePuzzle() {
    puzzlePositions = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    final random = Random();
    int previousEmpty = -1;
    for (int step = 0; step < 45 + puzzleLevel * 20; step++) {
      final emptyIndex = puzzlePositions.indexOf(8);
      final adjacent = <int>[];
      if (emptyIndex % 3 > 0) adjacent.add(emptyIndex - 1);
      if (emptyIndex % 3 < 2) adjacent.add(emptyIndex + 1);
      if (emptyIndex > 2) adjacent.add(emptyIndex - 3);
      if (emptyIndex < 6) adjacent.add(emptyIndex + 3);
      adjacent.remove(previousEmpty);
      final next = adjacent[random.nextInt(adjacent.length)];
      puzzlePositions[emptyIndex] = puzzlePositions[next];
      puzzlePositions[next] = 8;
      previousEmpty = emptyIndex;
    }
    puzzleComplete = false;
    moves = 0;
    puzzleStars = 0;
    showPuzzlePreview = false;
  }

  bool isPuzzleSolved() {
    for (int i = 0; i < 9; i++) {
      if (puzzlePositions[i] != i) return false;
    }
    return true;
  }

  void movePuzzlePiece(int index) {
    if (puzzleComplete) return;

    int emptyIndex = puzzlePositions.indexOf(8);
    List<int> adjacent = [];

    if (emptyIndex % 3 > 0) adjacent.add(emptyIndex - 1);
    if (emptyIndex % 3 < 2) adjacent.add(emptyIndex + 1);
    if (emptyIndex > 2) adjacent.add(emptyIndex - 3);
    if (emptyIndex < 6) adjacent.add(emptyIndex + 3);

    if (adjacent.contains(index)) {
      setState(() {
        int temp = puzzlePositions[index];
        puzzlePositions[index] = puzzlePositions[emptyIndex];
        puzzlePositions[emptyIndex] = temp;
        moves++;

        if (isPuzzleSolved()) {
          puzzleComplete = true;
          final target = 70 + puzzleLevel * 20;
          puzzleStars = moves <= target ? 3 : moves <= target + 30 ? 2 : 1;
          score += puzzleStars * 10;
        }
      });
    }
  }

  void flipCard(MatchPair card) {
    if (isChecking || card.isFlipped || card.isMatched) return;

    setState(() {
      card.isFlipped = true;
    });

    if (firstCard == null) {
      firstCard = card;
    } else {
      secondCard = card;
      isChecking = true;
      checkMatch();
    }
  }

  void checkMatch() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted || firstCard == null || secondCard == null) return;
      setState(() {
        matchAttempts++;
        if (firstCard!.name == secondCard!.name) {
          firstCard!.isMatched = true;
          secondCard!.isMatched = true;
          matchedPairs++;
          matchCombo++;
          bestMatchCombo = max(bestMatchCombo, matchCombo);
          score += 4 + matchCombo * 2;

          if (matchedPairs == matchCards.length ~/ 2) {
            Future.microtask(_showFinalResult);
          }
        } else {
          matchCombo = 0;
          firstCard!.isFlipped = false;
          secondCard!.isFlipped = false;
        }

        firstCard = null;
        secondCard = null;
        isChecking = false;
      });
    });
  }

  void checkRiddleAnswer() {
    setState(() {
      riddleResult = true;
      if (userAnswer.toLowerCase() ==
          riddleList[currentRiddleIndex]['answer']?.toLowerCase()) {
        riddleCorrect = true;
        score += 10;
      } else {
        riddleCorrect = false;
      }
    });
  }

  void nextRiddle() {
    if (currentRiddleIndex < riddleList.length - 1) {
      setState(() {
        currentRiddleIndex++;
        userAnswer = '';
        riddleResult = false;
        riddleCorrect = false;
      });
    } else {
      _showFinalResult();
    }
  }

  void selectAnswer(int index) {
    if (!showResult) {
      setState(() {
        selectedAnswerIndex = index;
      });
    }
  }

  void checkQuizAnswer() {
    setState(() {
      showResult = true;
      if (selectedAnswerIndex == qaList[currentQuestionIndex].correctIndex) {
        score += 10;
      }
    });
  }

  void nextQuizQuestion() {
    if (currentQuestionIndex < qaList.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = -1;
        showResult = false;
      });
    } else {
      _showFinalResult();
    }
  }

  void _showFinalResult() {
    showDialog(
      context: context,
      builder: (context) {
        String message;
        String emoji;
        Color bgColor;

        if (score >= 60) {
          message = '大师级表现！你已经解锁了本场挑战的最高荣誉。';
          emoji = '🏆';
          bgColor = const Color(0xFFE8F5E9);
        } else if (score >= 35) {
          message = '出色的文化探索者，再挑战一次就能冲击满星。';
          emoji = '✨';
          bgColor = const Color(0xFFFFF8E7);
        } else {
          message = '旅程已经开启，记住线索与工艺后再来突破纪录。';
          emoji = '📜';
          bgColor = const Color(0xFFFFEBEE);
        }

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: const Color(0xFFDEB887), width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 64)),
                const SizedBox(height: 20),
                const Text(
                  '挑战结算',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D3A1A),
                    fontFamily: 'STKaiti',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B4513), Color(0xFFA0522D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFFFFE4B5),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$score',
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'STKaiti',
                        ),
                      ),
                      const Text(
                        '文化能量',
                        style: TextStyle(
                          color: Color(0xFFFFE4B5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      currentGame = null;
                      score = 0;
                      currentQuestionIndex = 0;
                      selectedAnswerIndex = -1;
                      showResult = false;
                      shufflePuzzle();
                      initMatchGame();
                      currentRiddleIndex = 0;
                      userAnswer = '';
                      riddleResult = false;
                      matchedPairs = 0;
                      matchAttempts = 0;
                      matchCombo = 0;
                      bestMatchCombo = 0;
                      puzzleLevel = 0;
                      journeyLives = 3;
                      journeyCombo = 0;
                      _resetProcessGame();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B4513),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(
                        color: Color(0xFFFFE4B5),
                        width: 2,
                      ),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    '返回游戏选择',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'STKaiti',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void startGame(String gameType) {
    setState(() {
      currentGame = gameType;
      score = 0;
      currentQuestionIndex = 0;
      selectedAnswerIndex = -1;
      showResult = false;
      shufflePuzzle();
      initMatchGame();
      currentRiddleIndex = 0;
      userAnswer = '';
      riddleResult = false;
      matchedPairs = 0;
      matchAttempts = 0;
      matchCombo = 0;
      bestMatchCombo = 0;
      puzzleLevel = 0;
      _resetProcessGame();
      journeyIndex = 0;
      journeyChoice = null;
      journeyChecked = false;
      journeyRewards = [];
      journeyLives = 3;
      journeyCombo = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('互动体验'),
        backgroundColor: const Color(0xFF8B4513),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'STKaiti',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: currentGame == null ? _buildGameSelection() : _buildGameContent(),
    );
  }

  Widget _buildGameSelection() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4B2419), Color(0xFF963F27)],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '非遗游乐场',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'STKaiti',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '从手艺工坊到茶马古道，在挑战中解锁云南文化印记。',
                      style: TextStyle(color: Color(0xFFFFD9A0), fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => GridView.count(
                    crossAxisCount: constraints.maxWidth >= 900
                        ? 3
                        : constraints.maxWidth >= 560
                        ? 2
                        : 1,
                    childAspectRatio: constraints.maxWidth >= 900 ? 1.12 : 1.05,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    children: gameList.map(_buildGameCard).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(GameItem game) {
    final meta = <String, List<String>>{
      'puzzle': ['3 个关卡', '观察力', '约 5 分钟'],
      'match': ['6 组藏品', '记忆力', '连击加分'],
      'process': ['5 间工坊', '工艺推演', '2 次提示'],
      'journey': ['6 个驿站', '地域探索', '3 点体力'],
    }[game.gameType]!;
    return GestureDetector(
      onTap: () => startGame(game.gameType),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFCF5), Color(0xFFF1E3CC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFD9C09B)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x44DEB887),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAD7B8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(game.icon, style: const TextStyle(fontSize: 34)),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              game.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D3A1A),
                fontFamily: 'STKaiti',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              game.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: meta
                  .map(
                    (label) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.72),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2CDAA)),
                      ),
                      child: Text(label, style: const TextStyle(fontSize: 11)),
                    ),
                  )
                  .toList(),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFE4B5), width: 1),
              ),
              child: const Text(
                '开始游戏',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'STKaiti',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF8B4513),
                  size: 28,
                ),
                onPressed: () {
                  setState(() {
                    currentGame = null;
                  });
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentGameTitle(),
                      style: const TextStyle(
                        color: Color(0xFF5D3A1A),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'STKaiti',
                      ),
                    ),
                    Text(
                      _currentGameObjective(),
                      style: const TextStyle(
                        color: Color(0xFF8A725E),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFDEB887), width: 2),
                ),
                child: Text(
                  '文化能量  $score',
                  style: const TextStyle(
                    color: Color(0xFF8B4513),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (currentGame == 'quiz') _buildQuizGame(),
          if (currentGame == 'puzzle') _buildPuzzleGame(),
          if (currentGame == 'match') _buildMatchGame(),
          if (currentGame == 'riddle') _buildRiddleGame(),
          if (currentGame == 'process') _buildProcessGame(),
          if (currentGame == 'journey') _buildJourneyGame(),
        ],
      ),
    );
  }

  String _currentGameTitle() => switch (currentGame) {
    'puzzle' => '纹样修复局',
    'match' => '非遗记忆馆',
    'process' => '匠人工序工坊',
    'journey' => '茶马古道寻踪',
    _ => '非遗挑战',
  };

  String _currentGameObjective() => switch (currentGame) {
    'puzzle' => '移动图块复原三件云南非遗作品',
    'match' => '连续找到同类藏品，保持连击可获得额外分数',
    'process' => '拖动工序卡，还原真实制作流程',
    'journey' => '依据文化线索找到正确驿站，体力耗尽则旅程结束',
    _ => '',
  };

  Widget _buildQuizGame() {
    return Expanded(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B4513), Color(0xFFA0522D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFFE4B5), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x448B4513),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Text(
              qaList[currentQuestionIndex].question,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.5,
                fontFamily: 'STKaiti',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: qaList[currentQuestionIndex].options.length,
              itemBuilder: (context, index) {
                String option = qaList[currentQuestionIndex].options[index];
                bool isSelected = selectedAnswerIndex == index;
                bool isCorrect =
                    index == qaList[currentQuestionIndex].correctIndex;

                Color bgColor;
                Color borderColor;

                if (showResult) {
                  if (isCorrect) {
                    bgColor = const Color(0xFFE8F5E9);
                    borderColor = const Color(0xFF8B4513);
                  } else if (isSelected) {
                    bgColor = const Color(0xFFFFEBEE);
                    borderColor = const Color(0xFFDC143C);
                  } else {
                    bgColor = Colors.white;
                    borderColor = const Color(0xFFDEB887);
                  }
                } else {
                  bgColor = isSelected ? const Color(0xFFFFF8E7) : Colors.white;
                  borderColor = isSelected
                      ? const Color(0xFF8B4513)
                      : const Color(0xFFDEB887);
                }

                return GestureDetector(
                  onTap: () => selectAnswer(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor, width: 2),
                      color: bgColor,
                      boxShadow: isSelected && !showResult
                          ? const [
                              BoxShadow(
                                color: Color(0x44DEB887),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: showResult
                                ? isCorrect
                                      ? const Color(0xFF8B4513)
                                      : isSelected
                                      ? const Color(0xFFDC143C)
                                      : const Color(0xFFF5DEB3)
                                : isSelected
                                ? const Color(0xFF8B4513)
                                : const Color(0xFFF5DEB3),
                          ),
                          child: Center(
                            child: showResult && isCorrect
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : showResult && isSelected && !isCorrect
                                ? const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : Text(
                                    String.fromCharCode(65 + index),
                                    style: TextStyle(
                                      color:
                                          isSelected ||
                                              (showResult &&
                                                  (isCorrect || isSelected))
                                          ? Colors.white
                                          : const Color(0xFF8B4513),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              color: showResult && isCorrect
                                  ? const Color(0xFF8B4513)
                                  : const Color(0xFF5D3A1A),
                              fontWeight: showResult && isCorrect
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontFamily: 'STKaiti',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: showResult
                ? nextQuizQuestion
                : (selectedAnswerIndex >= 0 ? checkQuizAnswer : null),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B4513),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: Color(0xFFFFE4B5), width: 2),
              ),
              elevation: 5,
              disabledBackgroundColor: Colors.grey[300],
            ),
            child: Text(
              showResult
                  ? (currentQuestionIndex < qaList.length - 1 ? '下一题' : '查看结果')
                  : '确认答案',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'STKaiti',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPuzzleGame() {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Column(
              children: [
                _buildMissionBar(
                  progress: (puzzleLevel + 1) / puzzleImages.length,
                  left: '第 ${puzzleLevel + 1}/${puzzleImages.length} 关',
                  center: '移动 $moves 步',
                  right: '难度 ${['入门', '进阶', '大师'][puzzleLevel]}',
                ),
                const SizedBox(height: 18),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final boardSize = min(constraints.maxWidth, 430.0);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: boardSize,
                          height: boardSize,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8DDC9),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: const Color(0xFF8B4513),
                              width: 4,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x338B4513),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            crossAxisCount: 3,
                            children: puzzlePositions.map((position) {
                              if (position == 8) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3F2118),
                                  ),
                                  child: const Icon(
                                    Icons.open_with,
                                    color: Color(0x99FFFFFF),
                                  ),
                                );
                              }
                              return GestureDetector(
                                onTap: () => movePuzzlePiece(
                                  puzzlePositions.indexOf(position),
                                ),
                                child: _buildPuzzleTile(position, boardSize / 3),
                              );
                            }).toList(),
                          ),
                        ),
                        if (showPuzzlePreview)
                          Container(
                            width: boardSize,
                            height: boardSize,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: const Color(0xFFFFD9A0),
                                width: 4,
                              ),
                            ),
                            child: heritageImage(
                              puzzleImages[puzzleLevel],
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 18),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => setState(
                        () => showPuzzlePreview = !showPuzzlePreview,
                      ),
                      icon: Icon(
                        showPuzzlePreview ? Icons.visibility_off : Icons.image,
                      ),
                      label: Text(showPuzzlePreview ? '隐藏原图' : '按住思路看原图'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => setState(shufflePuzzle),
                      icon: const Icon(Icons.shuffle),
                      label: const Text('重新打乱'),
                    ),
                  ],
                ),
                if (puzzleComplete) ...[
                  const SizedBox(height: 18),
                  _buildSuccessPanel(
                    title: '纹样修复完成',
                    detail: '${'★' * puzzleStars}${'☆' * (3 - puzzleStars)}  共 $moves 步',
                    buttonText: puzzleLevel < puzzleImages.length - 1
                        ? '进入下一件藏品'
                        : '领取修复师勋章',
                    onPressed: () {
                      if (puzzleLevel < puzzleImages.length - 1) {
                        setState(() {
                          puzzleLevel++;
                          shufflePuzzle();
                        });
                      } else {
                        _showFinalResult();
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPuzzleTile(int position, double tileSize) {
    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFFFE4B5), width: 1.2),
        ),
        child: OverflowBox(
          alignment: Alignment.topLeft,
          minWidth: tileSize * 3,
          maxWidth: tileSize * 3,
          minHeight: tileSize * 3,
          maxHeight: tileSize * 3,
          child: Transform.translate(
            offset: Offset(
              -(position % 3) * tileSize,
              -(position ~/ 3) * tileSize,
            ),
            child: heritageImage(
              puzzleImages[puzzleLevel],
              width: tileSize * 3,
              height: tileSize * 3,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMatchGame() {
    return Expanded(
      child: Column(
        children: [
          _buildMissionBar(
            progress: matchedPairs / (matchCards.length / 2),
            left: '藏品 $matchedPairs/${matchCards.length ~/ 2}',
            center: '尝试 $matchAttempts 次',
            right: '连击 x${max(1, matchCombo)}',
          ),
          const SizedBox(height: 14),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth >= 760 ? 6 : 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.82,
                ),
                itemCount: matchCards.length,
                itemBuilder: (context, index) {
                  final card = matchCards[index];
                  final revealed = card.isFlipped || card.isMatched;
                  return InkWell(
                    onTap: () => flipCard(card),
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 240),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        gradient: revealed
                            ? null
                            : const LinearGradient(
                                colors: [Color(0xFF3D2118), Color(0xFFA9472B)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: card.isMatched
                              ? const Color(0xFFD99B32)
                              : const Color(0xFFD9C09B),
                          width: card.isMatched ? 3 : 1.5,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x228B4513),
                            blurRadius: 9,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: revealed
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                heritageImage(card.imageUrl, fit: BoxFit.cover),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(7),
                                    color: const Color(0xCC321B15),
                                    child: Text(
                                      card.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                if (card.isMatched)
                                  const Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Icon(
                                        Icons.verified,
                                        color: Color(0xFFFFD875),
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  color: Color(0xFFFFD9A0),
                                  size: 34,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '云南非遗',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'STKaiti',
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                matchedPairs = 0;
                matchAttempts = 0;
                matchCombo = 0;
                bestMatchCombo = 0;
                firstCard = null;
                secondCard = null;
                isChecking = false;
                initMatchGame();
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('重新布置展柜'),
          ),
        ],
      ),
    );
  }

  Widget _buildRiddleGame() {
    return Expanded(
      child: Column(
        children: [
          const Text(
            '非遗猜谜',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D3A1A),
              fontFamily: 'STKaiti',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B4513), Color(0xFFA0522D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFFE4B5), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x448B4513),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Text(
              riddleList[currentRiddleIndex]['riddle']!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.6,
                fontFamily: 'STKaiti',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) => userAnswer = value,
            enabled: !riddleResult,
            decoration: InputDecoration(
              hintText: '请输入答案',
              hintStyle: TextStyle(color: Colors.grey[500]),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFDEB887),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF8B4513),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 20),
          if (riddleResult)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: riddleCorrect
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: riddleCorrect
                      ? const Color(0xFF8B4513)
                      : const Color(0xFFDC143C),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    riddleCorrect ? '🎉 回答正确！' : '😅 回答错误',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: riddleCorrect
                          ? const Color(0xFF8B4513)
                          : const Color(0xFFDC143C),
                    ),
                  ),
                  if (!riddleCorrect)
                    Text(
                      '正确答案: ${riddleList[currentRiddleIndex]['answer']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8B4513),
                        fontFamily: 'STKaiti',
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: riddleResult
                ? nextRiddle
                : (userAnswer.isNotEmpty ? checkRiddleAnswer : null),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B4513),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: Color(0xFFFFE4B5), width: 2),
              ),
              elevation: 5,
              disabledBackgroundColor: Colors.grey[300],
            ),
            child: Text(
              riddleResult
                  ? (currentRiddleIndex < riddleList.length - 1
                        ? '下一题'
                        : '查看结果')
                  : '确认答案',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'STKaiti',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessGame() {
    final item = cultureList[processChallengeIndices[processItemIndex]];
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              children: [
                _buildMissionBar(
                  progress: (processItemIndex + 1) /
                      processChallengeIndices.length,
                  left:
                      '工坊 ${processItemIndex + 1}/${processChallengeIndices.length}',
                  center: '连胜 $processCombo',
                  right: '提示 $processHints',
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      heritageImage(
                        item.imageUrl,
                        height: 210,
                        width: double.infinity,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black87, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Text(
                          '请复原「${item.name}」的制作顺序',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: processSteps.length,
                  onReorderItem: processChecked
                      ? (_, _) {}
                      : (oldIndex, newIndex) {
                          setState(() {
                            final step = processSteps.removeAt(oldIndex);
                            processSteps.insert(newIndex, step);
                          });
                        },
                  itemBuilder: (context, index) {
                    return Container(
                      key: ValueKey('${processSteps[index]}-$index'),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: processChecked
                            ? (processSteps[index] == item.process[index]
                                  ? const Color(0xFFE5F2E8)
                                  : const Color(0xFFFFE8E1))
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: processChecked
                              ? (processSteps[index] == item.process[index]
                                    ? const Color(0xFF5A8F67)
                                    : const Color(0xFFC45A3D))
                              : const Color(0xFFD9C09B),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFF8B4513),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              processSteps[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Icon(Icons.drag_handle),
                        ],
                      ),
                    );
                  },
                ),
                if (processChecked) ...[
                  const SizedBox(height: 10),
                  Text(
                    processCorrect
                        ? '工序复原成功，获得 15 分！'
                        : '绿色表示位置正确。记住提示后，再调整一次顺序。',
                    style: TextStyle(
                      color: processCorrect
                          ? const Color(0xFF4F7E59)
                          : const Color(0xFFC45A3D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    OutlinedButton.icon(
                      onPressed: processHints > 0 && !processChecked
                          ? _useProcessHint
                          : null,
                      icon: const Icon(Icons.lightbulb_outline),
                      label: Text('匠人提示（$processHints）'),
                    ),
                    FilledButton.icon(
                      onPressed: !processChecked
                          ? _checkProcessOrder
                          : processCorrect
                          ? _nextProcessChallenge
                          : _retryProcessChallenge,
                      icon: Icon(
                        !processChecked
                            ? Icons.check
                            : processCorrect
                            ? Icons.arrow_forward
                            : Icons.refresh,
                      ),
                      label: Text(
                        !processChecked
                            ? '提交工序'
                            : processCorrect
                            ? '下一间工坊'
                            : '继续调整',
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

  Widget _buildJourneyGame() {
    final challenge = journeyChallenges[journeyIndex];
    final options = challenge['options'] as List<String>;
    final answer = challenge['answer'] as String;
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              children: [
                _buildMissionBar(
                  progress: (journeyIndex + 1) / journeyChallenges.length,
                  left: '驿站 ${journeyIndex + 1}/${journeyChallenges.length}',
                  center: '连中 $journeyCombo',
                  right: '${'♥' * journeyLives}${'♡' * (3 - journeyLives)}',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    journeyChallenges.length,
                    (index) => Container(
                      width: 54,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: index <= journeyIndex
                            ? const Color(0xFFB7462A)
                            : const Color(0xFFE2D5C2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4C2418), Color(0xFF8B4513)],
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.explore,
                        color: Color(0xFFFFD9A0),
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        challenge['clue'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ...options.map((option) {
                  final selected = journeyChoice == option;
                  final isAnswer = option == answer;
                  Color color = Colors.white;
                  if (journeyChecked && isAnswer) {
                    color = const Color(0xFFE4F2E7);
                  }
                  if (journeyChecked && selected && !isAnswer) {
                    color = const Color(0xFFFFE5DE);
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () => _checkJourneyAnswer(option),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFFB7462A)
                                : const Color(0xFFD9C09B),
                            width: selected ? 2 : 1,
                          ),
                        ),
                        child: Text(
                          option,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  );
                }),
                if (journeyChecked) ...[
                  const SizedBox(height: 12),
                  Text(
                    journeyChoice == answer
                        ? '定位成功！获得「${challenge['reward']}」'
                        : '这次走偏了，正确地点是 $answer，体力 -1。',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (journeyRewards.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      children: journeyRewards
                          .map(
                            (reward) => Chip(
                              label: Text(reward),
                              avatar: const Icon(Icons.stars, size: 17),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _nextJourneyStop,
                    icon: const Icon(Icons.directions_walk),
                    label: Text(
                      journeyIndex < journeyChallenges.length - 1
                          ? '前往下一站'
                          : '完成旅程',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMissionBar({
    required double progress,
    required String left,
    required String center,
    required String right,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 13, 16, 11),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD9C09B)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(left, textAlign: TextAlign.left)),
              Expanded(
                child: Text(
                  center,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  right,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFFB7462A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.clamp(0, 1),
              minHeight: 7,
              backgroundColor: const Color(0xFFE9DDCB),
              color: const Color(0xFFB7462A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessPanel({
    required String title,
    required String detail,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF4D7), Color(0xFFE7F1DF)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD29A38)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 14,
        runSpacing: 12,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D3A1A),
                ),
              ),
              const SizedBox(height: 4),
              Text(detail, style: const TextStyle(color: Color(0xFF8B4513))),
            ],
          ),
          FilledButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_forward),
            label: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
