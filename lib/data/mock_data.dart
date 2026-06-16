class CultureItem {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final String location;
  final String level;
  final String history;
  final List<String> process;
  final List<String> features;

  CultureItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.level,
    required this.history,
    required this.process,
    required this.features,
  });
}

class Inheritor {
  final String id;
  final String name;
  final String avatar;
  final String title;
  final String cultureName;
  final String description;
  final List<String> achievements;

  Inheritor({
    required this.id,
    required this.name,
    required this.avatar,
    required this.title,
    required this.cultureName,
    required this.description,
    required this.achievements,
  });
}

class Story {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime date;

  Story({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.date,
  });
}

class QAContent {
  final String question;
  final String answer;
  final List<String> options;
  final int correctIndex;

  QAContent({
    required this.question,
    required this.answer,
    required this.options,
    required this.correctIndex,
  });
}

class GameItem {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String gameType;

  GameItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.gameType,
  });
}

class PuzzlePiece {
  final int id;
  final int correctPosition;
  final int currentPosition;
  final String imageUrl;

  PuzzlePiece({
    required this.id,
    required this.correctPosition,
    required this.currentPosition,
    required this.imageUrl,
  });
}

class MatchPair {
  final String id;
  final String name;
  final String imageUrl;
  bool isMatched;
  bool isFlipped;

  MatchPair({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isMatched = false,
    this.isFlipped = false,
  });
}

List<CultureItem> cultureList = [
  CultureItem(
    id: '1',
    name: '扎染技艺',
    category: '传统技艺',
    description:
        '扎染是云南大理白族的传统手工艺，以其独特的蓝白相间图案闻名于世。扎染工艺历史悠久，最早可以追溯到秦汉时期，经过千百年的发展，形成了独特的艺术风格。',
    imageUrl: 'assets/images/heritage/tie_dye.png',
    location: '大理白族自治州',
    level: '国家级',
    history: '大理白族扎染以周城最具代表性。蓝靛染料、针线扎结与反复浸染共同形成自然晕纹，每一件作品都具有不可复制的手工痕迹。',
    process: ['设计纹样', '绞扎布料', '蓝靛浸染', '氧化晾晒', '拆线漂洗'],
    features: ['蓝白对比', '冰裂晕纹', '植物染料', '一布一纹'],
  ),
  CultureItem(
    id: '2',
    name: '傣族织锦',
    category: '传统技艺',
    description: '傣族织锦历史悠久，图案精美，色彩鲜艳，具有浓郁的民族特色。每一幅织锦都蕴含着傣族人民对自然、生活和美的理解。',
    imageUrl: 'assets/images/heritage/dai_brocade.png',
    location: '西双版纳傣族自治州',
    level: '国家级',
    history: '傣锦以木织机手工织造，纹样常见孔雀、大象、菩提树和几何图案，是傣族服饰、佛幡与生活礼俗的重要组成部分。',
    process: ['纺线染色', '整经上机', '挑花织纹', '收边整理'],
    features: ['经纬显花', '几何构成', '高饱和配色', '礼俗象征'],
  ),
  CultureItem(
    id: '3',
    name: '建水紫陶',
    category: '传统技艺',
    description: '建水紫陶以其独特的"阴刻阳填"工艺和古朴典雅的风格著称。采用独特的雕刻和填色工艺，经过多次打磨抛光而成。',
    imageUrl: 'assets/images/heritage/jianshui_pottery.png',
    location: '红河哈尼族彝族自治州',
    level: '国家级',
    history: '建水紫陶与江苏宜兴陶、广西钦州陶、四川荣昌陶并称中国四大名陶。其无釉磨光和书画装饰形成温润含蓄的东方审美。',
    process: ['制泥陈腐', '拉坯成型', '湿坯书画', '阴刻阳填', '烧制磨光'],
    features: ['无釉磨光', '阴刻阳填', '书画入陶', '声如磬明'],
  ),
  CultureItem(
    id: '4',
    name: '彝族刺绣',
    category: '传统技艺',
    description: '彝族刺绣色彩斑斓，图案丰富，展现了彝族人民的智慧和创造力。刺绣图案多取材于自然景物和生活场景。',
    imageUrl: 'assets/images/heritage/yi_embroidery.png',
    location: '楚雄彝族自治州',
    level: '国家级',
    history: '彝族刺绣被称作“穿在身上的史诗”。纹样承载族群记忆、自然崇拜与生活祝愿，广泛用于衣襟、袖口、头帕和挎包。',
    process: ['构图配色', '剪裁底布', '平绣挑花', '锁边拼接'],
    features: ['火焰纹样', '植物母题', '强烈色彩', '服饰叙事'],
  ),
  CultureItem(
    id: '5',
    name: '纳西古乐',
    category: '传统音乐',
    description: '纳西古乐是世界上最古老的音乐之一，被誉为"音乐活化石"。保留了许多唐宋时期的音乐元素，具有极高的历史价值。',
    imageUrl: 'assets/images/heritage/naxi_music.png',
    location: '丽江市',
    level: '国家级',
    history: '纳西古乐主要流传于丽江，由洞经音乐、白沙细乐等传统音乐形态构成。古谱、古器与老艺人的活态演奏使其具有珍贵研究价值。',
    process: ['工尺谱识读', '乐器合奏', '曲牌衔接', '师徒传习'],
    features: ['古谱传承', '多器合奏', '曲牌结构', '活态演出'],
  ),
  CultureItem(
    id: '6',
    name: '普洱茶制作技艺',
    category: '传统技艺',
    description: '普洱茶以其独特的发酵工艺和越陈越香的特点闻名海内外。制作过程包括采摘、萎凋、揉捻、晒干、渥堆等多个环节。',
    imageUrl: 'assets/images/heritage/puer_tea.png',
    location: '普洱市',
    level: '国家级',
    history: '普洱茶制作依托云南大叶种茶和茶马古道传统。晒青毛茶经蒸压或后发酵形成独特风味，体现山地生态与民族茶俗。',
    process: ['鲜叶采摘', '摊晾杀青', '揉捻解块', '日光晒青', '蒸压或渥堆'],
    features: ['云南大叶种', '日光晒青', '后期转化', '茶马古道'],
  ),
  CultureItem(
    id: '7',
    name: '傣族孔雀舞',
    category: '传统舞蹈',
    description: '傣族孔雀舞通过手形、步态和身体曲线模拟孔雀饮水、开屏、飞翔等姿态，是傣族审美、信仰和节庆生活的重要表达。',
    imageUrl: 'assets/images/heritage/peacock_dance.png',
    location: '西双版纳傣族自治州',
    level: '国家级',
    history: '孔雀在傣族文化中象征吉祥、善良与美丽。孔雀舞既有民间自娱性表演，也形成了具有鲜明舞台艺术特色的传承体系。',
    process: ['观察取象', '手形训练', '三道弯体态', '鼓点配合', '情境表演'],
    features: ['三道弯', '腕指灵动', '象脚鼓伴奏', '自然崇拜'],
  ),
  CultureItem(
    id: '8',
    name: '云南花灯戏',
    category: '传统戏剧',
    description: '云南花灯戏由民间歌舞、灯会表演和地方小戏发展而来，唱腔明快、语言生动，具有浓郁的乡土生活气息。',
    imageUrl: 'assets/images/heritage/huadeng_opera.png',
    location: '昆明市、玉溪市等地',
    level: '国家级',
    history: '花灯戏广泛流传于云南各地，不同地区形成各具特色的声腔与表演风格。扇、帕等道具和载歌载舞的形式是其鲜明标志。',
    process: ['采集民间小调', '排演唱腔', '身段走场', '乐队伴奏', '灯会展演'],
    features: ['载歌载舞', '方言唱词', '扇帕表演', '生活喜剧'],
  ),
  CultureItem(
    id: '9',
    name: '白族三道茶',
    category: '民俗',
    description: '白族三道茶以“一苦、二甜、三回味”的礼序待客，通过烤茶、冲泡与配料变化表达人生况味和宾主情谊。',
    imageUrl: 'assets/images/heritage/puer_tea.png',
    location: '大理白族自治州',
    level: '国家级',
    history: '三道茶与白族节庆、婚礼和日常待客紧密相连，是茶艺、礼仪、歌舞与口头传统相结合的活态文化实践。',
    process: ['选茶备器', '烘烤茶叶', '头道苦茶', '二道甜茶', '三道回味茶'],
    features: ['以茶待客', '人生寓意', '礼仪秩序', '歌舞相伴'],
  ),
  CultureItem(
    id: '10',
    name: '东巴造纸技艺',
    category: '传统技艺',
    description: '纳西族东巴纸以荛花等高山植物为原料，经过浸泡、蒸煮、捣浆和抄纸制成，主要用于书写东巴经书。',
    imageUrl: 'assets/images/heritage/naxi_music.png',
    location: '丽江市',
    level: '国家级',
    history: '东巴纸韧性强、耐虫蛀，是东巴象形文字和宗教典籍得以长期保存的重要载体，也见证了纳西族知识传承。',
    process: ['采集荛花', '浸泡蒸煮', '舂捣成浆', '竹帘抄纸', '压榨晾晒'],
    features: ['植物纤维', '手工抄造', '经书载体', '耐久防蛀'],
  ),
  CultureItem(
    id: '11',
    name: '剑川木雕',
    category: '传统美术',
    description: '剑川木雕以浮雕、透雕和圆雕见长，题材涵盖花鸟瑞兽、历史故事与民间生活，广泛应用于白族建筑和家具。',
    imageUrl: 'assets/images/heritage/tie_dye.png',
    location: '大理白族自治州剑川县',
    level: '国家级',
    history: '剑川木雕依托当地建筑传统发展，工匠以师徒方式传承选材、构图、凿刻和髹饰经验，形成繁而不乱的装饰风格。',
    process: ['选材开料', '绘制纹样', '打坯凿刻', '精修打磨', '上色髹饰'],
    features: ['层次丰富', '建筑装饰', '透雕技法', '吉祥纹样'],
  ),
  CultureItem(
    id: '12',
    name: '哈尼族多声部民歌',
    category: '传统音乐',
    description: '哈尼族多声部民歌以自然和声、领唱应答和多声部交织为特色，常在劳动、节庆和婚恋活动中演唱。',
    imageUrl: 'assets/images/heritage/naxi_music.png',
    location: '红河哈尼族彝族自治州',
    level: '国家级',
    history: '民歌在村寨公共生活中口传心授，旋律与梯田农耕节律、山林环境和族群交往密切相关，是社区记忆的重要声音档案。',
    process: ['确定歌头', '领唱起腔', '声部加入', '即兴应答', '集体收腔'],
    features: ['自然和声', '无伴奏合唱', '劳动叙事', '口传心授'],
  ),
  CultureItem(
    id: '13',
    name: '傣族慢轮制陶',
    category: '传统技艺',
    description: '傣族慢轮制陶使用木制慢轮和拍打工具手工成型，器物多用于炊煮、储水和宗教礼俗，保留早期制陶特征。',
    imageUrl: 'assets/images/heritage/jianshui_pottery.png',
    location: '西双版纳傣族自治州',
    level: '国家级',
    history: '慢轮制陶多由家庭女性传承，从取土到露天烧制均依赖经验判断，是材料知识、生活需求与社区协作结合的传统。',
    process: ['采土炼泥', '泥条盘筑', '慢轮拍打', '刻画装饰', '露天烧制'],
    features: ['慢轮成型', '生活器皿', '露天烧陶', '女性传承'],
  ),
  CultureItem(
    id: '14',
    name: '彝族左脚舞',
    category: '传统舞蹈',
    description: '彝族左脚舞以月琴、三弦伴奏，舞者围圈踏步、甩手和换脚，节奏热烈，是楚雄彝族节庆社交的重要活动。',
    imageUrl: 'assets/images/heritage/peacock_dance.png',
    location: '楚雄彝族自治州',
    level: '国家级',
    history: '左脚舞兼具娱乐、交往和礼俗功能，舞步看似简洁，却依靠集体节奏和队形变化形成强烈的社区凝聚力。',
    process: ['月琴起调', '围圈搭肩', '左脚起步', '踏步换向', '集体收势'],
    features: ['围圈共舞', '左脚起步', '月琴伴奏', '节庆社交'],
  ),
  CultureItem(
    id: '15',
    name: '腾冲皮影戏',
    category: '传统戏剧',
    description: '腾冲皮影戏集雕刻、绘画、说唱和操纵于一体，艺人隔着幕布操纵彩色皮影，以灯光投射演绎历史和民间故事。',
    imageUrl: 'assets/images/heritage/huadeng_opera.png',
    location: '保山市腾冲市',
    level: '国家级',
    history: '腾冲皮影吸收中原戏曲与边地文化元素，角色造型细腻、唱腔多样，是滇西乡村节庆和人生礼俗中的重要表演。',
    process: ['选皮制革', '描样雕刻', '敷彩装杆', '排练唱腔', '幕前操影'],
    features: ['灯影造型', '雕刻彩绘', '一人多技', '滇西唱腔'],
  ),
  CultureItem(
    id: '16',
    name: '阿昌族户撒刀锻制技艺',
    category: '传统技艺',
    description: '户撒刀以选钢、锻打、淬火、磨制和装饰等复杂工序制成，兼具生产工具、生活用品和民族文化象征的功能。',
    imageUrl: 'assets/images/heritage/jianshui_pottery.png',
    location: '德宏傣族景颇族自治州',
    level: '国家级',
    history: '户撒刀锻制经验由阿昌族工匠世代积累，对火候、钢材和淬火水温有精细判断，体现边疆民族金属工艺智慧。',
    process: ['选钢下料', '炉火锻打', '成型淬火', '开刃磨制', '制作刀鞘'],
    features: ['反复锻打', '火候判断', '锋利耐用', '民族纹饰'],
  ),
];

List<Inheritor> inheritorList = [
  Inheritor(
    id: '1',
    name: '张仕绅',
    avatar: 'assets/images/heritage/张仕绅.png',
    title: '国家级非遗传承人',
    cultureName: '白族扎染技艺',
    description:
        '张仕绅，男，白族，1941年出生，大理白族自治州大理市喜洲镇周城村人。张仕绅生长于白族扎染世家，1956年跟随母亲学习祖传扎染技艺，通过20多年的不断摸索，依靠祖传的扎染制作工艺、扎染方式和发酵液“母滴”，创新发展了传统扎染的扎法、花色品种，针法上从原有的5种扎染技法发展到现在的挑扎、勾扎、组合扎等26种，花型从原来的3种发展到“福禄寿喜”、“花鸟鱼虫”等多种图案系列。产品品种从原来的匹布、床单发展到现在的窗帘、门帘、桌布、围巾、头巾、背包、挂包、鞋、帽、衣服等。他曾获农业部乡镇企业出口创汇“金龙奖”，云南省乡镇企业局“质量厂长”奖，大理州“优秀厂长”奖，大理州“有突出贡献的专业技术人才”奖和“乡土拔尖人才”奖，农业部“全国优秀供销员”称号。',
    achievements: [
      '2007年被认定为白族扎染技艺国家级非物质文化遗产传承人',
      '将白族扎染针法从5种发展为26种',
      '推动扎染厂产品远销日本、美国等10多个国家和地区',
    ],
  ),
  Inheritor(
    id: '2',
    name: '曹明宽',
    avatar: 'assets/images/heritage/曹明宽.jpg',
    title: '国家级非遗传承人',
    cultureName: '阿昌族宗教祭祀活动',
    description:
        '曹明宽，男，阿昌族，1943年出生，德宏傣族景颇族自治州梁河县九保乡勐科行政村小龙潭村民小组人。阿昌族称主持祭祀活动的人为“活袍”，被视为阿昌族传统文化的重要守护人。曹明宽30岁开始主持各种宗教祭祀活动，能用阿昌族语、汉语、傣语、景颇语主持祭祀活动，主要是在丧葬时念经发送亡灵，驱神送鬼，祈求安康。他能完整唱诵本民族创世神话史诗《遮帕麻和遮咪麻》，娴熟掌握本民族的各种祭祀程式、相关禁忌和习俗礼仪，在梁河县具有一定知名度，前来请他主持活动的阿昌族、景颇族、傣族群众很多。',
    achievements: [
      '2005年《遮帕麻和遮咪麻》被公布为第一批国家级非物质文化遗产名录',
      '阿昌族宗教祭祀活动的重要传承人和传播者',
      '多年来在阿昌族重大传统节日“阿露窝罗节”盛会上念诵创世史诗',
    ],
  ),
  Inheritor(
    id: '3',
    name: '和训',
    avatar: 'assets/images/heritage/和训.jpg',
    title: '国家级非遗传承人',
    cultureName: '纳西族东巴画',
    description:
        '和训，男，纳西族，1926年出生，丽江市玉龙纳西族自治县塔城乡依陇村委会暑明村人。和训出身于东巴世家，6岁时即随其父和尔大东巴学习东巴文字、东巴画和各种祭祀礼仪规程，兼学制作各种面具、课牌、剪纸和纸扎技艺。年轻时即成为暑明村和姓家族的第六代东巴，东巴名“温之娃”。和训掌握大量东巴文字，熟悉各种东巴舞蹈，能主持大小规模的东巴祭祀活动，包括祈福类、禳鬼类、丧葬类等多种仪式。',
    achievements: [
      '丽江市民俗礼仪活动著名主持人',
      '培养和秀东、杨玉华等弟子传承东巴技艺',
      '在丽江纳西族群众中有很高的知名度和影响力',
    ],
  ),
  Inheritor(
    id: '4',
    name: '思华章',
    avatar: 'assets/images/heritage/思华章.jpg',
    title: '国家级非遗传承人',
    cultureName: '傣族剪纸',
    description:
        '思华章，男，傣族，1923年出生，德宏傣族景颇族自治州潞西市勐焕街道办事处人。思华章是德宏州享有盛名的民间艺术工艺大师，精通剪纸、绘画、雕刻等，被当地傣族称为“撒那”。他20岁拜师傣族民间工艺大师杨八学习剪纸技艺。他的剪纸作品质朴、传神，造型优美，使用纸、布、竹作材料，剪制出孔雀、大象、凤凰、龙、人物、花卉、虫鸟等图案，民族风格浓郁，构图严谨统一，工艺精美细腻。他还使用刀、剪、锯等工具和一些形状各异的小凿，以铝皮、铁皮等金属为材料，加工制作成佛伞、佛幡等赕佛器具和民族建筑装饰材料。',
    achievements: [
      '1999年被云南省文化厅命名为“云南省民族民间美术师”',
      '作品多次参加州、市举办的各类民间工艺美术展览',
      '曾到大连、深圳、秦皇岛等地展出',
    ],
  ),
  Inheritor(
    id: '5',
    name: '王杰锋',
    avatar: 'assets/images/heritage/王杰峰.jpg',
    title: '国家级非遗传承人',
    cultureName: '芦笙制作技艺',
    description:
        '王杰锋，男，苗族，1960年出生，昭通市大关县天星镇中心村人。王杰锋19岁开始跟随父亲学做芦笙，熟练掌握了芦笙的整套制作工序和流程，成为芦笙制作技艺第五代传人。经过多年的摸索，王杰锋在继承传统技艺的基础上加以改进，对簧片和发音管距的长短与定调的关系作了反复的试验，用手风琴、电子琴校音，所以他制作的芦笙和传统芦笙相比，声音更响亮、清晰，音调也较准确。他做的芦笙小至30厘米，大至1米多，也可根据用户的要求制作8管或10管芦笙，工艺精良，造型美观。',
    achievements: [
      '1992年中国第三届艺术节开幕式游演中，苗族表演队所用的100把芦笙都出自他之手',
      '芦笙制作技艺名扬云、贵、川三省的20多个市、县、区',
      '20多年来已卖出芦笙3000余把，被当地群众称为“芦笙世家”',
    ],
  ),
  Inheritor(
    id: '6',
    name: '王利',
    avatar: 'assets/images/heritage/王利.jpg',
    title: '国家级非遗传承人',
    cultureName: '傈僳族民歌',
    description:
        '王利，男，傈僳族，1929年出生，怒江傈僳族自治州泸水县古登乡干本村人。王利自幼酷爱民歌演唱，先后拜村中德高望重的益邓、郁丽仙二位老艺人为师，学习傈僳民歌演唱和“期奔”弹奏，并形成自己独特的演唱风格。他弹唱的傈僳“期奔”功底深厚，技艺高超，在当地傈僳族中影响甚广。他长期坚持在傈僳族欢度传统节日、进新房、婚嫁、丧事等不同的场合演唱不同的曲调，无论是以情歌小调为主的“优叶”，还是以吟唱古歌和叙事长诗为主的“木刮”，或是以自由演唱为主的对歌“摆时”，他都能即兴创作，自如演唱。',
    achievements: [
      '1958年到昆明参加民间歌舞展演',
      '参加怒江州碧江县组织的“木刮”比赛并获一等奖',
      '1994年、1999年云南电视台和中央电视台先后对其进行了采访报道',
    ],
  ),
  Inheritor(
    id: '7',
    name: '约相',
    avatar: 'assets/images/heritage/约相.jpg',
    title: '国家级非遗传承人',
    cultureName: '傣族孔雀舞',
    description:
        '约相，男，傣族，1948年出生，德宏傣族景颇族自治州瑞丽市勐卯镇姐东村民委员会喊沙村民小组人。约相从小就喜爱民间流行的孔雀舞，年轻时先后跟随孔雀舞大师帅哏撒卜、毛相习练孔雀舞。他饲养孔雀、观察孔雀的生活习性和动作，把孔雀放入林中观察孔雀林中漫步、戏水照影、雌雄交配、拖尾亮翅、登枝、开屏等动作，把孔雀入林、起飞、入睡、醒来、远眺、扒沙、照影、饮水、开屏等优美的姿态运用到孔雀舞中，因此，他跳的孔雀舞形神兼备，出神入化，惟妙惟肖，把孔雀的习性展现得淋漓尽致。',
    achievements: [
      '曾两次参加文化部举办的全国性会演和比赛并获奖',
      '两次参加全国少数民族运动会表演“孔雀拳”获表演奖',
      '多次被聘请到深圳、广州、台湾等地及缅甸进行表演和文化交流',
      '培养了孔雀舞传承人20多人，三代人共同传承孔雀舞',
    ],
  ),
  Inheritor(
    id: '8',
    name: '李鸿源',
    avatar: 'assets/images/heritage/李鸿源.jpg',
    title: '国家级非遗传承人',
    cultureName: '花灯音乐',
    description:
        '李鸿源，男，汉族，1937年4月出生，玉溪市红塔区人。李鸿源受其父亲李寿影响，自幼喜唱滇剧、花灯，1955年进入玉溪专区人民戏院花灯团后，在薜国兴、杨炯明、欧阳璋等老师的指导下从事花灯音乐和歌曲创作。他熟练掌握花灯音乐的源流、曲牌，先后为《莫悉女》等200多出花灯剧目设计音乐和唱腔，并多次在省级和国家级赛事中获奖。其创腔既有浓郁的花灯韵味，又符合人物的性格和思想感情。在继承玉溪花灯音乐的基础上，李鸿源还吸收、融会其他音乐素材对玉溪花灯音乐进行创新，总结出花灯创腔套用装饰、重点突出、一曲多变、曲牌连接、摘句集曲、多声色彩六种技法。',
    achievements: [
      '主编了40万字的戏曲音乐集成云南卷丛书《玉溪花灯音乐》',
      '出版了个人专集《李鸿源花灯音乐作品选》',
      '2006年被云南省省委宣传部、云南省文化厅、云南省文联授予“云南文学艺术成就奖”',
    ],
  ),
  Inheritor(
    id: '9',
    name: '熊自义',
    avatar: 'assets/images/heritage/熊自义.jpg',
    title: '国家级非遗传承人',
    cultureName: '傈僳族阿尺木刮',
    description:
        '熊自义，男，傈僳族，1941年出生，迪庆藏族自治州维西傈僳族自治县叶枝镇新洛村人。熊自义从小聪慧过人，喜爱傈僳族传统文化，后拜傈僳族音节文字的创造者哇忍波为师，学习傈僳族传统文化和木刮调，通过自身刻苦努力，系统掌握了直鲁木刮（放羊调）、尼义木刮（劳动调）、尼吃木刮（情调）、处于木刮（丧调）、马华木刮（婚调）、阔时木刮（过年调）等调式，成为哇忍波硕果仅存的嫡传弟子。他不仅向老师学习民族音乐，还继承了老师勤劳俭朴、公正无私、乐于助人的好品德，是邻近村寨节庆或婚丧嫁娶活动中不可缺少的核心人物。',
    achievements: [
      '组织了80人的阿尺木刮表演队',
      '排练出五角星、八卦图、字形图案等复杂的队形',
      '2002年被云南省文化厅、云南省民族事务委员会命名为“民间音乐师”',
    ],
  ),
];

List<Story> storyList = [
  Story(
    id: '1',
    title: '扎染技艺的起源与发展',
    content:
        '扎染技艺起源于秦汉时期，经过千百年的发展，形成了独特的艺术风格。云南大理的周城村是著名的"扎染之乡"，这里几乎家家户户都从事扎染制作。扎染不仅是一门技艺，更是白族文化的重要组成部分。',
    imageUrl: 'assets/images/heritage/tie_dye.png',
    date: DateTime(2023, 6, 15),
  ),
  Story(
    id: '2',
    title: '傣族织锦的文化内涵',
    content:
        '傣族织锦不仅是一种手工艺，更是傣族文化的重要载体。每一幅织锦都蕴含着傣族人民对自然、生活和美的理解。织锦图案多取材于傣族的神话传说、自然景物和日常生活。',
    imageUrl: 'assets/images/heritage/dai_brocade.png',
    date: DateTime(2023, 8, 22),
  ),
  Story(
    id: '3',
    title: '建水紫陶的独特工艺',
    content:
        '建水紫陶采用独特的"阴刻阳填"工艺，即在陶坯上雕刻图案，然后填入彩色泥料，经过多次打磨抛光而成。这一工艺使得建水紫陶具有独特的艺术魅力和收藏价值。',
    imageUrl: 'assets/images/heritage/jianshui_pottery.png',
    date: DateTime(2023, 10, 8),
  ),
  Story(
    id: '4',
    title: '孔雀舞中的自然观',
    content: '傣族舞者通过手指、手腕、肩部与腰胯的连续变化表现孔雀的灵动形态。舞蹈并非简单模仿动物，而是人与自然和谐相处观念的身体表达。',
    imageUrl: 'assets/images/heritage/peacock_dance.png',
    date: DateTime(2024, 3, 18),
  ),
  Story(
    id: '5',
    title: '花灯戏里的云南生活',
    content: '花灯戏的题材常来自赶集、农事、婚恋和邻里生活。轻快的曲调、方言化的唱词与幽默表演，使舞台成为记录地方社会生活的鲜活空间。',
    imageUrl: 'assets/images/heritage/huadeng_opera.png',
    date: DateTime(2024, 5, 20),
  ),
  Story(
    id: '6',
    title: '创作故事：蓝布晒场的第一堂课',
    content:
        '清晨的周城晒场上，学徒急着拆开刚染好的布。老师傅没有阻止，只让她比较阳光下尚未充分氧化的绿色与逐渐显现的靛蓝。那一天，她第一次明白扎染不只是控制图案，也要给植物染料和时间留下位置。本故事为基于扎染工序的教学情境创作。',
    imageUrl: 'assets/images/heritage/tie_dye.png',
    date: DateTime(2025, 2, 12),
  ),
  Story(
    id: '7',
    title: '创作故事：织机旁的孔雀纹',
    content:
        '女孩想把手机里的孔雀照片直接织进傣锦，外婆却先让她从一个菱形和两条折线开始。经纬一点点增加，孔雀并未被照搬，却以傣锦自己的语言出现。她由此理解，创新不是替换传统语法，而是在理解语法后继续表达。本故事为教学情境创作。',
    imageUrl: 'assets/images/heritage/dai_brocade.png',
    date: DateTime(2025, 3, 9),
  ),
  Story(
    id: '8',
    title: '创作故事：一把没有立刻淬火的刀',
    content:
        '年轻学徒看到刀坯已经通红，催师傅赶紧淬火。师傅却继续观察炉火和钢材颜色，因为同样的红色在不同光线下意味着不同温度。户撒刀的关键经验无法只写成一个数字，它存在于长期观察、失败和身体记忆中。本故事为教学情境创作。',
    imageUrl: 'assets/images/heritage/jianshui_pottery.png',
    date: DateTime(2025, 4, 18),
  ),
  Story(
    id: '9',
    title: '创作故事：古乐社的新谱架',
    content:
        '社区乐社来了几位不会工尺谱的中学生。老艺人没有降低曲目难度，而是在谱架上加了节奏颜色和乐器进入提示。排练结束后，孩子们仍然要学习传统记谱，但他们已经先听见了各声部如何彼此回应。本故事为教学情境创作。',
    imageUrl: 'assets/images/heritage/naxi_music.png',
    date: DateTime(2025, 5, 6),
  ),
  Story(
    id: '10',
    title: '创作故事：茶山上的一场雨',
    content:
        '晒青进行到一半，山雨突然落下。制茶人和学生迅速收起竹席，又在雨停后重新判断叶片含水量。原定流程被天气改变，大家才真正理解传统技艺不是僵硬步骤，而是对环境变化作出有经验的回应。本故事为教学情境创作。',
    imageUrl: 'assets/images/heritage/puer_tea.png',
    date: DateTime(2025, 6, 14),
  ),
  Story(
    id: '11',
    title: '创作故事：花灯戏里的新赶集',
    content:
        '戏班准备排一出当代赶集小戏，演员把直播带货、快递站和老街摊贩写进唱词，却保留花灯戏的曲调、方言节奏和扇帕身段。观众笑声不断，也认出了熟悉的生活。本故事为基于花灯戏创作机制的教学情境创作。',
    imageUrl: 'assets/images/heritage/huadeng_opera.png',
    date: DateTime(2025, 8, 23),
  ),
];

List<QAContent> qaList = [
  QAContent(
    question: '云南扎染技艺主要分布在哪个地区？',
    answer: '大理白族自治州',
    options: ['西双版纳傣族自治州', '大理白族自治州', '丽江市', '昆明市'],
    correctIndex: 1,
  ),
  QAContent(
    question: '以下哪项是非遗项目"建水紫陶"的独特工艺？',
    answer: '阴刻阳填',
    options: ['青花瓷', '阴刻阳填', '景泰蓝', '珐琅彩'],
    correctIndex: 1,
  ),
  QAContent(
    question: '纳西古乐被誉为什么？',
    answer: '音乐活化石',
    options: ['东方明珠', '音乐活化石', '艺术瑰宝', '文化遗产'],
    correctIndex: 1,
  ),
  QAContent(
    question: '普洱茶的特点是什么？',
    answer: '越陈越香',
    options: ['越陈越香', '色泽金黄', '口感清甜', '香气浓郁'],
    correctIndex: 0,
  ),
  QAContent(
    question: '傣族织锦主要分布在云南哪个地区？',
    answer: '西双版纳傣族自治州',
    options: ['大理白族自治州', '西双版纳傣族自治州', '普洱市', '红河州'],
    correctIndex: 1,
  ),
];

List<String> categories = ['全部', '传统技艺', '传统美术', '传统音乐', '传统舞蹈', '传统戏剧', '民俗'];

class RegionInfo {
  final String name;
  final int count;
  final String description;
  final List<String> famousItems;
  final double x;
  final double y;

  RegionInfo({
    required this.name,
    required this.count,
    required this.description,
    required this.famousItems,
    required this.x,
    required this.y,
  });
}

List<RegionInfo> yunnanRegions = [
  RegionInfo(
    name: '昆明',
    count: 20,
    description:
        '云南省省会，是全省政治、经济、文化中心。昆明地区拥有丰富的非遗资源，包括滇剧、花灯戏等传统戏曲，以及剪纸、木雕等传统技艺。',
    famousItems: ['滇剧', '花灯戏', '昆明剪纸', '官渡饵块制作技艺'],
    x: 0.61,
    y: 0.43,
  ),
  RegionInfo(
    name: '大理',
    count: 12,
    description: '大理白族自治州以其独特的白族文化闻名。这里的扎染技艺、三道茶制作技艺等都是国家级非物质文化遗产。',
    famousItems: ['白族扎染技艺', '三道茶制作技艺', '大理剪纸', '剑川木雕'],
    x: 0.34,
    y: 0.42,
  ),
  RegionInfo(
    name: '丽江',
    count: 8,
    description: '丽江市是纳西族的主要聚居地，拥有世界文化遗产丽江古城和纳西古乐等珍贵的非遗项目。',
    famousItems: ['纳西古乐', '东巴造纸技艺', '白沙细乐', '纳西族服饰'],
    x: 0.37,
    y: 0.24,
  ),
  RegionInfo(
    name: '西双版纳',
    count: 15,
    description: '西双版纳傣族自治州是傣族文化的代表地区，拥有丰富的傣族传统技艺和民俗文化。',
    famousItems: ['傣族织锦', '泼水节', '贝叶经制作', '傣族慢轮制陶'],
    x: 0.58,
    y: 0.84,
  ),
  RegionInfo(
    name: '红河',
    count: 10,
    description: '红河哈尼族彝族自治州以哈尼梯田和建水紫陶闻名，拥有丰富的少数民族文化遗产。',
    famousItems: ['建水紫陶', '哈尼族多声部民歌', '彝族烟盒舞', '过桥米线制作'],
    x: 0.69,
    y: 0.63,
  ),
  RegionInfo(
    name: '楚雄',
    count: 7,
    description: '楚雄彝族自治州是彝族文化的重要传承地，拥有丰富的彝族传统技艺和节庆活动。',
    famousItems: ['彝族刺绣', '火把节', '彝族左脚舞', '牟定彝族刺绣'],
    x: 0.49,
    y: 0.48,
  ),
  RegionInfo(
    name: '普洱',
    count: 9,
    description: '普洱市是普洱茶的故乡，拥有悠久的茶叶制作历史和丰富的少数民族文化。',
    famousItems: ['普洱茶制作技艺', '景迈山古茶林', '布朗族弹唱', '傣族象脚鼓舞'],
    x: 0.47,
    y: 0.70,
  ),
  RegionInfo(
    name: '玉溪',
    count: 6,
    description: '玉溪市以花灯戏和抚仙湖闻名，拥有独特的滇中文化特色。',
    famousItems: ['玉溪花灯戏', '通海高台', '江川木雕', '华宁陶'],
    x: 0.60,
    y: 0.55,
  ),
  RegionInfo(
    name: '曲靖',
    count: 11,
    description: '曲靖地处滇黔交界，多民族文化与交通交流相互交织，拥有爨文化、传统戏曲、民歌舞蹈和特色饮食制作技艺。',
    famousItems: ['宣威火腿制作技艺', '会泽斑铜', '彝族海马舞', '爨体书法'],
    x: .72,
    y: .29,
  ),
  RegionInfo(
    name: '昭通',
    count: 8,
    description: '昭通位于滇川黔结合部，古道文化和多民族生活孕育了洞经音乐、民间文学、刺绣与传统食品制作技艺。',
    famousItems: ['昭通洞经音乐', '苗族芦笙舞', '彝族服饰', '昭通酱制作'],
    x: .48,
    y: .14,
  ),
  RegionInfo(
    name: '文山',
    count: 9,
    description: '文山壮族苗族自治州民族节庆丰富，铜鼓文化、坡芽歌书、壮族刺绣和传统药用知识具有鲜明地域特征。',
    famousItems: ['坡芽歌书', '壮族铜鼓舞', '苗族蜡染', '壮族刺绣'],
    x: .84,
    y: .57,
  ),
  RegionInfo(
    name: '保山',
    count: 8,
    description: '保山是南方丝绸之路的重要节点，腾冲皮影、传统造纸、玉雕和多民族歌舞共同构成滇西文化景观。',
    famousItems: ['腾冲皮影戏', '腾宣纸制作', '永子制作技艺', '彝族打歌'],
    x: .15,
    y: .56,
  ),
  RegionInfo(
    name: '德宏',
    count: 7,
    description: '德宏傣族景颇族自治州边境文化多元，阿昌族锻造、景颇族目瑙纵歌和傣族剪纸体现开放而鲜活的文化生态。',
    famousItems: ['户撒刀锻制技艺', '目瑙纵歌', '傣族剪纸', '葫芦丝制作'],
    x: .11,
    y: .72,
  ),
  RegionInfo(
    name: '临沧',
    count: 8,
    description: '临沧是重要茶文化区域，也是佤族、拉祜族、布朗族等民族聚居地，木鼓舞、古茶制作和口头传统资源丰富。',
    famousItems: ['佤族木鼓舞', '沧源崖画传说', '古茶制作技艺', '拉祜族芦笙舞'],
    x: .26,
    y: .74,
  ),
  RegionInfo(
    name: '怒江',
    count: 6,
    description: '怒江傈僳族自治州高山峡谷环境保存了傈僳族、怒族、独龙族的歌舞、乐器、织毯和节庆传统。',
    famousItems: ['傈僳族民歌', '达比亚舞', '独龙毯编织', '阔时节'],
    x: .20,
    y: .31,
  ),
  RegionInfo(
    name: '迪庆',
    count: 7,
    description: '迪庆藏族自治州位于滇西北高原，锅庄舞、藏族黑陶、传统医药和寺院音乐体现高原文化与多民族交流。',
    famousItems: ['藏族锅庄舞', '尼西黑陶', '藏医药', '弦子舞'],
    x: .30,
    y: .13,
  ),
];

List<GameItem> gameList = [
  GameItem(
    id: '2',
    title: '非遗拼图',
    description: '将打乱的非遗图片拼完整',
    icon: '🧩',
    gameType: 'puzzle',
  ),
  GameItem(
    id: '3',
    title: '非遗配对',
    description: '找出相同的非遗图片配对',
    icon: '🔗',
    gameType: 'match',
  ),
  GameItem(
    id: '5',
    title: '非遗工坊',
    description: '把被打乱的制作工序恢复成正确顺序',
    icon: '🪡',
    gameType: 'process',
  ),
  GameItem(
    id: '6',
    title: '茶马古道寻踪',
    description: '根据地域线索解锁沿途的非遗印记',
    icon: '🧭',
    gameType: 'journey',
  ),
];

List<Map<String, dynamic>> journeyChallenges = [
  {
    'clue': '这里有苍山洱海，蓝白布匹经过绞扎和蓝靛浸染形成独特纹样。',
    'answer': '大理',
    'options': ['大理', '曲靖', '文山', '临沧'],
    'reward': '白族扎染纹样',
  },
  {
    'clue': '古城里仍能听到洞经音乐与白沙细乐，东巴象形文字也在这里流传。',
    'answer': '丽江',
    'options': ['保山', '丽江', '昭通', '玉溪'],
    'reward': '纳西古乐音符',
  },
  {
    'clue': '热带雨林、孔雀舞、象脚鼓与傣锦共同构成这里鲜明的文化印象。',
    'answer': '西双版纳',
    'options': ['怒江', '楚雄', '西双版纳', '昆明'],
    'reward': '孔雀羽印记',
  },
  {
    'clue': '紫陶以阴刻阳填和无釉磨光闻名，哈尼族多声部民歌也在此传唱。',
    'answer': '红河',
    'options': ['红河', '德宏', '迪庆', '曲靖'],
    'reward': '紫陶印章',
  },
  {
    'clue': '火把节的欢歌与彝族刺绣交相辉映，古老太阳历也在这里留下文化印记。',
    'answer': '楚雄',
    'options': ['楚雄', '保山', '怒江', '昭通'],
    'reward': '太阳历徽记',
  },
  {
    'clue': '花灯歌舞在村寨广场流传，悠扬唱腔与扇舞讲述滇中百姓的生活故事。',
    'answer': '昆明',
    'options': ['德宏', '迪庆', '昆明', '临沧'],
    'reward': '花灯彩扇',
  },
];

List<String> puzzleImages = [
  'assets/images/heritage/tie_dye.png',
  'assets/images/heritage/dai_brocade.png',
  'assets/images/heritage/jianshui_pottery.png',
];

List<MatchPair> matchPairs = [
  MatchPair(
    id: '1',
    name: '扎染',
    imageUrl: 'assets/images/heritage/tie_dye.png',
  ),
  MatchPair(
    id: '2',
    name: '扎染',
    imageUrl: 'assets/images/heritage/tie_dye.png',
  ),
  MatchPair(
    id: '3',
    name: '织锦',
    imageUrl: 'assets/images/heritage/dai_brocade.png',
  ),
  MatchPair(
    id: '4',
    name: '织锦',
    imageUrl: 'assets/images/heritage/dai_brocade.png',
  ),
  MatchPair(
    id: '5',
    name: '紫陶',
    imageUrl: 'assets/images/heritage/jianshui_pottery.png',
  ),
  MatchPair(
    id: '6',
    name: '紫陶',
    imageUrl: 'assets/images/heritage/jianshui_pottery.png',
  ),
  MatchPair(
    id: '7',
    name: '刺绣',
    imageUrl: 'assets/images/heritage/yi_embroidery.png',
  ),
  MatchPair(
    id: '8',
    name: '刺绣',
    imageUrl: 'assets/images/heritage/yi_embroidery.png',
  ),
  MatchPair(
    id: '9',
    name: '孔雀舞',
    imageUrl: 'assets/images/heritage/peacock_dance.png',
  ),
  MatchPair(
    id: '10',
    name: '孔雀舞',
    imageUrl: 'assets/images/heritage/peacock_dance.png',
  ),
  MatchPair(
    id: '11',
    name: '花灯戏',
    imageUrl: 'assets/images/heritage/huadeng_opera.png',
  ),
  MatchPair(
    id: '12',
    name: '花灯戏',
    imageUrl: 'assets/images/heritage/huadeng_opera.png',
  ),
];

List<Map<String, String>> riddleList = [
  {'riddle': '蓝白相间，花纹精美，白布入染缸，出来变花衣', 'answer': '扎染'},
  {'riddle': '丝线穿梭，五彩斑斓，经纬交织，锦绣前程', 'answer': '织锦'},
  {'riddle': '泥土为身，刻刀为笔，阴刻阳填，紫韵天成', 'answer': '建水紫陶'},
  {'riddle': '彩线飞舞，银针穿梭，花鸟虫鱼，跃然布上', 'answer': '刺绣'},
  {'riddle': '古乐悠扬，穿越千年，白沙细乐，古韵长存', 'answer': '纳西古乐'},
];
