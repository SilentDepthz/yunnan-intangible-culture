const fs = require('fs');
const path = require('path');

const outDir = path.join(__dirname, '..', 'docs', 'report-figures');
fs.mkdirSync(outDir, { recursive: true });

const palette = {
  bg1: '#FFF9EF',
  bg2: '#F2DEC0',
  ink: '#432116',
  muted: '#7B5946',
  red: '#B7462A',
  red2: '#8F3E26',
  brown: '#5A2C21',
  gold: '#D7A55F',
  cream: '#FFFDF8',
  pale: '#FFF1D7',
  line: '#9A5A35',
};

function esc(s) {
  return String(s).replace(/[&<>"']/g, (c) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&apos;'
  }[c]));
}

function svg(title, subtitle, body, { width = 1400, height = 900 } = {}) {
  return `<svg width="${width}" height="${height}" viewBox="0 0 ${width} ${height}" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="${width}" y2="${height}" gradientUnits="userSpaceOnUse">
      <stop stop-color="${palette.bg1}"/>
      <stop offset="1" stop-color="${palette.bg2}"/>
    </linearGradient>
    <linearGradient id="dark" x1="0" y1="0" x2="1" y2="1">
      <stop stop-color="${palette.brown}"/>
      <stop offset="1" stop-color="${palette.red}"/>
    </linearGradient>
    <linearGradient id="bar" x1="0" y1="0" x2="1" y2="0">
      <stop stop-color="${palette.red}"/>
      <stop offset="1" stop-color="#E3AA61"/>
    </linearGradient>
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="160%">
      <feDropShadow dx="0" dy="14" stdDeviation="14" flood-color="#6C351F" flood-opacity=".16"/>
    </filter>
    <marker id="arrow" viewBox="0 0 12 12" refX="10" refY="6" markerWidth="10" markerHeight="10" orient="auto">
      <path d="M2 2L10 6L2 10Z" fill="${palette.red2}"/>
    </marker>
    <style>
      .title{font-family:"Microsoft YaHei","PingFang SC",Arial,sans-serif;font-size:42px;font-weight:800;fill:${palette.ink}}
      .subtitle{font-family:"Microsoft YaHei","PingFang SC",Arial,sans-serif;font-size:18px;fill:${palette.muted}}
      .h{font-family:"Microsoft YaHei","PingFang SC",Arial,sans-serif;font-size:25px;font-weight:800;fill:${palette.ink}}
      .h2{font-family:"Microsoft YaHei","PingFang SC",Arial,sans-serif;font-size:20px;font-weight:800;fill:${palette.ink}}
      .p{font-family:"Microsoft YaHei","PingFang SC",Arial,sans-serif;font-size:16px;fill:${palette.muted}}
      .tag{font-family:"Microsoft YaHei","PingFang SC",Arial,sans-serif;font-size:15px;font-weight:700;fill:${palette.red2}}
      .white{font-family:"Microsoft YaHei","PingFang SC",Arial,sans-serif;font-size:22px;font-weight:800;fill:#fff}
      .whiteSmall{font-family:"Microsoft YaHei","PingFang SC",Arial,sans-serif;font-size:15px;fill:#FFE8BF}
      .num{font-family:Georgia,serif;font-size:35px;font-weight:800;fill:${palette.red}}
    </style>
  </defs>
  <rect width="${width}" height="${height}" rx="42" fill="url(#bg)"/>
  <circle cx="${width - 120}" cy="110" r="105" fill="#E7C58D" opacity=".28"/>
  <circle cx="130" cy="${height - 110}" r="145" fill="${palette.red}" opacity=".07"/>
  <text x="${width / 2}" y="74" text-anchor="middle" class="title">${esc(title)}</text>
  <text x="${width / 2}" y="110" text-anchor="middle" class="subtitle">${esc(subtitle)}</text>
  ${body}
</svg>`;
}

function card(x, y, w, h, title, lines = [], opts = {}) {
  const fill = opts.dark ? 'url(#dark)' : palette.cream;
  const stroke = opts.dark ? palette.gold : '#D7B06E';
  const titleClass = opts.dark ? 'white' : 'h2';
  const lineClass = opts.dark ? 'whiteSmall' : 'p';
  return `<g filter="url(#shadow)">
    <rect x="${x}" y="${y}" width="${w}" height="${h}" rx="26" fill="${fill}" stroke="${stroke}" stroke-width="1.5"/>
    <text x="${x + w / 2}" y="${y + 42}" text-anchor="middle" class="${titleClass}">${esc(title)}</text>
    ${lines.map((l, i) => `<text x="${x + w / 2}" y="${y + 76 + i * 26}" text-anchor="middle" class="${lineClass}">${esc(l)}</text>`).join('\n')}
  </g>`;
}

function arrow(x1, y1, x2, y2, dashed = false) {
  return `<path d="M${x1} ${y1}L${x2} ${y2}" stroke="${palette.red2}" stroke-width="4" stroke-linecap="round" marker-end="url(#arrow)"${dashed ? ' stroke-dasharray="10 10"' : ''}/>`;
}

const architecture = svg(
  '系统总体架构图',
  'Flutter Web 展示平台的页面、组件、数据与外部地图服务关系',
  `
  ${card(80, 170, 1240, 98, '表现层 Presentation Layer', ['Material 3 主题系统 · 响应式导航 · 图文卡片 · 游戏反馈'], { dark: true })}
  ${card(80, 315, 220, 138, '首页', ['主题视觉', '地图入口', '推荐内容'])}
  ${card(330, 315, 220, 138, '非遗项目', ['分类筛选', '关键词搜索', '详情展示'])}
  ${card(580, 315, 220, 138, '传承故事', ['传承人', '成就介绍', '故事时间线'])}
  ${card(830, 315, 220, 138, '互动体验', ['拼图', '配对', '工坊', '寻踪'])}
  ${card(1080, 315, 220, 138, '关于说明', ['项目背景', '主题价值', '地图展示'])}
  ${arrow(700, 268, 700, 312)}
  ${card(155, 535, 260, 138, '地图组件', ['YunnanMapWidget', 'GeoJSON 解析', '州市点击联动'])}
  ${card(455, 535, 220, 138, '图片组件', ['HeritageImage', '资源加载', '失败容错'])}
  ${card(715, 535, 260, 138, '数据层', ['mock_data.dart', '项目/人物/故事/游戏', '区域信息'])}
  ${card(1015, 535, 230, 138, '外部地图服务', ['阿里云 DataV', '云南行政区 GeoJSON', '网络失败降级'])}
  ${arrow(280, 456, 285, 532)}
  ${arrow(940, 456, 845, 532)}
  ${arrow(845, 604, 1010, 604)}
  <rect x="170" y="735" width="1060" height="74" rx="24" fill="#FFF5E5" stroke="#D7B06E"/>
  <text x="700" y="766" text-anchor="middle" class="h2">核心设计思想</text>
  <text x="700" y="793" text-anchor="middle" class="p">以地图建立空间认知，以项目库提供知识内容，以人物故事强化文化传承，以互动游戏提升学习参与度。</text>
  `
);

const businessFlow = svg(
  '业务流程图',
  '用户从进入首页到完成文化学习与互动体验的完整路径',
  `
  <path d="M150 455C280 230 432 225 560 408C688 592 850 548 994 350C1066 250 1136 240 1240 295" stroke="${palette.red}" stroke-width="22" stroke-linecap="round" opacity=".9"/>
  <path d="M150 455C280 230 432 225 560 408C688 592 850 548 994 350C1066 250 1136 240 1240 295" stroke="#FFE7BA" stroke-width="4" stroke-linecap="round" stroke-dasharray="12 14"/>
  ${card(70, 475, 225, 145, '1. 首页认知', ['主题视觉', '推荐轮播', '数据概览'])}
  ${card(300, 190, 225, 145, '2. 地图探索', ['点击州市', '查看区域非遗', '空间化理解'])}
  ${card(545, 465, 225, 145, '3. 项目检索', ['搜索筛选', '查看详情', '理解工艺流程'])}
  ${card(790, 190, 225, 145, '4. 故事阅读', ['传承人物', '成就资料', '文化叙事'])}
  ${card(1035, 360, 225, 145, '5. 游戏体验', ['拼图配对', '工序复原', '寻踪结算'])}
  <rect x="250" y="690" width="900" height="72" rx="24" fill="url(#dark)" filter="url(#shadow)"/>
  <text x="700" y="721" text-anchor="middle" class="white">业务闭环</text>
  <text x="700" y="750" text-anchor="middle" class="whiteSmall">浏览认知 → 地图定位 → 内容学习 → 传承理解 → 游戏巩固</text>
  `
);

const dataModel = svg(
  '核心数据结构关系图',
  'mock_data.dart 中非遗项目、区域、传承人、故事和游戏数据的组织关系',
  `
  ${card(545, 170, 310, 150, 'CultureItem 非遗项目', ['名称 / 类别 / 地点 / 级别', '历史价值 / 制作流程', '图片与传承说明'], { dark: true })}
  ${card(105, 420, 260, 140, 'RegionInfo 区域信息', ['州市名称', '代表项目', '文化标签'])}
  ${card(405, 420, 260, 140, 'Inheritor 传承人', ['人物简介', '代表技艺', '成就列表'])}
  ${card(735, 420, 260, 140, 'Story 非遗故事', ['故事标题', '图文内容', '时间线展示'])}
  ${card(1035, 420, 260, 140, 'GameItem 游戏数据', ['游戏入口', '题目/关卡', '奖励反馈'])}
  ${arrow(545, 245, 370, 420)}
  ${arrow(635, 320, 535, 418)}
  ${arrow(765, 320, 865, 418)}
  ${arrow(855, 245, 1035, 420)}
  <rect x="150" y="655" width="1100" height="92" rx="26" fill="#FFFDF8" stroke="#D7B06E" filter="url(#shadow)"/>
  <text x="700" y="690" text-anchor="middle" class="h2">数据驱动页面展示</text>
  <text x="700" y="720" text-anchor="middle" class="p">非遗项目是内容核心，地图区域、传承人、故事和互动游戏分别从空间、人物、叙事和体验四个维度补充展示。</text>
  `
);

const mapFlow = svg(
  '地图交互流程图',
  '云南州市 GeoJSON 加载、区域点击识别与非遗信息面板联动',
  `
  ${card(80, 210, 230, 150, '1. 获取边界', ['请求阿里云 DataV', '云南州市 GeoJSON', '网络数据入口'])}
  ${arrow(315, 285, 405, 285)}
  ${card(410, 210, 230, 150, '2. 绘制地图', ['解析多边形坐标', '缩放到画布范围', '绘制州市轮廓'])}
  ${arrow(645, 285, 735, 285)}
  ${card(740, 210, 230, 150, '3. 点击识别', ['监听用户点击', '判断命中区域', '更新选中状态'])}
  ${arrow(975, 285, 1065, 285)}
  ${card(1070, 210, 230, 150, '4. 信息联动', ['匹配 RegionInfo', '筛选相关项目', '展示详情面板'])}
  <path d="M1190 368C1110 510 895 540 700 540C505 540 290 510 210 368" stroke="${palette.red2}" stroke-width="4" stroke-dasharray="12 12" marker-end="url(#arrow)" fill="none"/>
  ${card(430, 540, 540, 115, '容错机制', ['GeoJSON 请求失败时启用本地备用地图组件，保证页面结构和浏览体验完整。'], { dark: true })}
  <rect x="200" y="725" width="1000" height="66" rx="22" fill="#FFF5E5" stroke="#D7B06E"/>
  <text x="700" y="767" text-anchor="middle" class="p">交互价值：把非遗项目从列表信息转化为可点击、可定位、可比较的地域文化信息。</text>
  `
);

const gameMechanics = svg(
  '互动游戏机制图',
  '四类小游戏围绕识图、记忆、工艺和地域四种学习目标展开',
  `
  <rect x="520" y="180" width="360" height="120" rx="32" fill="url(#dark)" filter="url(#shadow)"/>
  <text x="700" y="226" text-anchor="middle" class="white">互动体验中心</text>
  <text x="700" y="260" text-anchor="middle" class="whiteSmall">文化能量 · 关卡进度 · 连击反馈 · 星级结算</text>
  ${card(105, 405, 245, 150, '纹样修复局', ['滑块拼图', '原图提示', '星级评价'])}
  ${card(405, 405, 245, 150, '非遗记忆馆', ['翻牌配对', '六组藏品', '连击加分'])}
  ${card(705, 405, 245, 150, '匠人工坊', ['拖拽排序', '工序复原', '有限提示'])}
  ${card(1005, 405, 245, 150, '古道寻踪', ['地域线索', '体力机制', '奖励收集'])}
  ${arrow(610, 300, 225, 400)}
  ${arrow(670, 300, 525, 400)}
  ${arrow(730, 300, 825, 400)}
  ${arrow(790, 300, 1125, 400)}
  <rect x="165" y="665" width="1070" height="78" rx="24" fill="#FFFDF8" stroke="#D7B06E" filter="url(#shadow)"/>
  <text x="700" y="696" text-anchor="middle" class="h2">学习目标对应关系</text>
  <text x="700" y="725" text-anchor="middle" class="p">图像识别 → 名称记忆 → 工艺理解 → 地域关联，形成从感知到理解的渐进式学习路径。</text>
  `
);

const deployment = svg(
  '项目构建与部署流程图',
  'Flutter 项目从本地开发到 Web 静态资源交付的流程',
  `
  ${card(80, 230, 220, 135, '1. 本地开发', ['编辑 Dart 页面', '维护数据与图片', '调试交互效果'])}
  ${arrow(305, 298, 405, 298)}
  ${card(410, 230, 220, 135, '2. 依赖安装', ['flutter pub get', '读取 pubspec.yaml', '加载 assets'])}
  ${arrow(635, 298, 735, 298)}
  ${card(740, 230, 220, 135, '3. 代码验证', ['dart analyze', 'dart format', 'flutter test'])}
  ${arrow(965, 298, 1065, 298)}
  ${card(1070, 230, 220, 135, '4. Web 构建', ['flutter build web', '生成 build/web', '静态资源输出'])}
  <path d="M1180 370V505C1180 540 1145 565 1110 565H290C255 565 220 540 220 505V370" stroke="${palette.red2}" stroke-width="4" stroke-dasharray="12 12" marker-end="url(#arrow)" fill="none"/>
  ${card(490, 535, 420, 130, '5. 静态部署', ['将 build/web 部署到服务器、校园平台或静态托管服务', '用户通过浏览器访问，无需后端服务'], { dark: true })}
  <rect x="210" y="735" width="980" height="64" rx="22" fill="#FFF5E5" stroke="#D7B06E"/>
  <text x="700" y="776" text-anchor="middle" class="p">交付特点：项目可以作为 Flutter Web 静态站点提交，适合课程展示、答辩演示和后续在线部署。</text>
  `
);

const files = {
  '01-system-architecture.svg': architecture,
  '02-business-flow.svg': businessFlow,
  '03-data-model.svg': dataModel,
  '04-map-interaction.svg': mapFlow,
  '05-game-mechanics.svg': gameMechanics,
  '06-deployment-flow.svg': deployment,
};

for (const [name, content] of Object.entries(files)) {
  fs.writeFileSync(path.join(outDir, name), content, 'utf8');
}

console.log(`Generated ${Object.keys(files).length} report figures in ${outDir}`);
