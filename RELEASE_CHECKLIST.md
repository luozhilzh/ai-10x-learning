# ai-10x-learning 开源发布清单

> 最后核验：2026-07-23。✅ = 本次本地实测通过；☐ = 需你（或发布动作）完成。

---

## A. 仓库就绪度（已实测 ✅）

- ✅ **MIT LICENSE** 存在，版权 `luozhi` 2026
- ✅ **SKILL.md frontmatter** 仅 `name` + `description`（符合 Agent Skills 开放标准，Claude Code / Codex / Cursor / WorkBuddy 通用）
- ✅ **协议层无硬编码工具名**（能力感知三层降级：有联网工具→取证；agentic 无工具→标 `[需核实]`；纯对话→用户即来源）
- ✅ **.gitignore** 覆盖 `.DS_Store` / `*.log` / `.workbuddy/` / `.env` / `node_modules` / `__pycache__`
- ✅ **examples 脱敏扫描**：无密钥 / 邮箱 / 手机号 / 微信等敏感信息泄漏
- ✅ **git 工作树干净**（最新 commit `1b7d50e` 含 C/D/E 全部改动）
- ✅ **无大二进制文件**，纯文本包，clone 轻量

## B. 跨工具安装（已实测 ✅）

- ✅ **install.sh --all** 在 fake HOME 下成功装到 4 个目标目录（`~/.workbuddy` / `~/.claude` / `~/.codex` / `~/.cursor`），文件齐全
- ✅ 安装副本中的样例卡经 `scripts/validate_card.py` 校验 **[PASS]**（8256 字节，无残留占位符，DOCTYPE/`</html>` 正常）
- ✅ **README 安装说明**覆盖 WorkBuddy / Claude Code / Codex / Cursor（用户级 + 项目级），以及 ChatGPT / Gemini / 豆包 / 元宝 / DeepSeek 的 `references/prompts.md` 纯文本复制路径

## C. 内容健康（建议发布前复核 ☐）

- ☐ 最后通读 `SKILL.md` + `prompts.md`：确认无"内部梗 / 私有链接 / 个人项目名"等仅你自己看得懂的内容
- ☐ 三份 examples Markdown + 两张 HTML 卡：确认对外读者可独立理解（无上下文依赖）

## D. 发布元数据（建库后填 ☐）

- ☐ 仓库描述 + **Topics**（建议：`agent-skills`, `claude-code`, `cursor`, `codex`, `workbuddy`, `learning`, `prompt-engineering`, `study-method`）
- ☐ README 顶部徽章（可选，不阻塞）：License / 版本
- ☐ 首次 Release：打 tag **v1.0.0**，Release note 见下方模板

## E. 发布动作（☐ 你执行）

- ☐ 在 GitHub（或等价平台）创建仓库（建议名 `ai-10x-learning`，Public）
- ☐ `git remote add origin <url>` && `git push -u origin main`（先确认默认分支名是 `main` 还是 `master`）
- ☐ 打 tag：`git tag v1.0.0` && `git push --tags`
- ☐ 发布 Release，粘贴下方 Release note
- ☐ （可选）同步到 Claude Code / Cursor 社区、知识星球、X 等渠道

## F. 发布后验证（☐）

- ☐ 别人 clone 后跑 `./install.sh` 成功
- ☐ 别人在 WorkBuddy / Claude Code 输入 `/ai-10x-learning` 能正确加载

---

## 附：Release note 模板（v1.0.0）

```markdown
# AI 10x 学习法 Skill v1.0.0

用 AI 把任何知识学到「能教别人、能考倒自己」的 10 步闭环，做成一个跨工具通用 skill。

## 它能做什么
- 三模式：研究(1–4) / 学习(5–10) / 全闭环(1–10)
- 开场学习画像对齐，避免「你以为的」和「AI 理解的」主题不一致
- 能力感知联网取证（无工具时不伪造，标 [需核实]）
- 考到崩溃 + 费曼 + 速查表，真学会而非只拿答案
- 可选导出单文件 HTML 学习卡（步骤 10.5，零依赖、双击可开）

## 借鉴自 Daliu-Awesome-Skills 的 5 个特性
1. HTML 成果卡交付层
2. 能力感知联网（三层降级）
3. 逐环交接 checklist
4. 开场画像与主题对齐
5. 反触发护栏

## 安装
- 有 skill 目录的工具（WorkBuddy / Claude Code / Codex / Cursor）：`./install.sh`
- 纯对话工具（ChatGPT / Gemini / 豆包 / 元宝 / DeepSeek）：复制 `references/prompts.md` 全文粘贴

## 许可
MIT —— Copyright (c) 2026 luozhi
```
