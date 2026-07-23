# HTML 成果卡 · 视觉规范（design.md）

本文件约束 assets/template.html 的生成，以及 AI 填空时的视觉一致性。核心原则：自有中性配色、零外部依赖、单文件可双击打开。

## 1. 配色（本 skill 自有，非第三方品牌色）

| 用途 | 变量 | 值 | 说明 |
|---|---|---|---|
| 页面底色 | --bg | #f8fafc | 浅灰蓝 |
| 卡片表面 | --surface | #ffffff | 白 |
| 正文 | --ink | #1e293b | 深灰 |
| 次要文字 | --muted | #64748b | 中灰 |
| 描边 | --line | #e2e8f0 | 浅灰 |
| 主色 蓝 | --blue | #2563eb | 标题 / 阶梯 / 主强调 |
| 蓝浅底 | --blue-soft | #eff6ff | chip / 阶梯底 |
| 辅色 青 | --teal | #0d9488 | 速查表闪卡 |
| 青浅底 | --teal-soft | #f0fdfa | 闪卡底 |
| 点缀 琥珀 | --amber | #d97706 | 目标 chip / 警示 |
| 琥珀浅底 | --amber-soft | #fffbeb | 目标 chip 底 |

> 不使用 sage / forest / chartreuse 等第三方视觉品牌色，避免授权争议。本调色板为本 skill 原创，可自由用于 MIT 范围内的产物。

## 2. 形态规则

- 圆角 --radius: 12px；卡片内圆角 10px
- 禁止 box-shadow（无阴影，靠描边区分层次）
- 字体：系统字体栈（-apple-system, BlinkMacSystemFont, Segoe UI, PingFang SC, Microsoft YaHei, sans-serif）
- 最大宽度 820px 居中；移动端靠 auto-fill 网格自适应
- 配色对比度需满足正文与背景 ≥ 4.5:1

## 3. 组件类

| 类 | 用途 |
|---|---|
| .chip | 角色 / 预算 / 目标标签（圆角 pill）；.chip.teal / .chip.amber 为配色变体 |
| .ladder | 学习阶梯容器 |
| .lvl | 单级（圆形序号 .num + .body 说明） |
| .grid | 速查表闪卡网格 |
| .flash | 单张速查卡（.q 问题 + .a 答案） |
| .bank | 题库容器 |
| .qa | 单题（.q 问题 + .a 参考答案） |

## 4. 可视化约定

- 内联 SVG，不引用外部文件
- 阶梯优先用 HTML .lvl 行（已足够清晰）；若改用 SVG，描边用 --blue，圆角 8
- 速查表用 .flash 网格，不用图片
- 矛盾图等复杂图可后续扩展，核心卡暂不含

## 5. AI 填空约定（生成 HTML 时）

- 仅替换占位符（如 {{TITLE}}、{{LADDER}} 等），不得改动 CSS / 结构
- 每段内容来自对应已产步骤（受 SKILL.md 硬规则 7 约束），不引入上游未支撑的新内容
- 不插入外部 script / link 等资源；如要交互只用内联脚本
- 纯对话工具：输出完整 HTML 代码块，由用户存成 .html 双击打开
- 若用户只要速查表 / 题库，可只渲染对应段（删掉无关 section）
