#!/usr/bin/env python3
"""validate_card.py — 校验 ai-10x-learning 导出的 HTML 学习卡。

目的：防止「导出打不开的卡 / 占位符没填完」这类回归。
步骤 10.5 生成卡片后跑一次即可自证有效。

检查项：
  1. 文件存在且可用 UTF-8 读取
  2. 无残留占位符 {{...}}（模板 7 个占位符必须全部替换）
  3. 以 <!DOCTYPE html> 开头（否则浏览器进入 quirks 模式）
  4. 含 <html> 根标签且正常闭合 </html>
  5. 体积合理（> 500 字节，排除空壳）

用法：
  python scripts/validate_card.py <path-to-html> [<path> ...]

退出码：
  0 = 全部通过； 1 = 有失败项； 2 = 参数缺失
"""
import os
import re
import sys

REQUIRED_PATTERNS = [
    (r"<!DOCTYPE\s+html", "缺少 <!DOCTYPE html> 声明（浏览器会进入 quirks 模式）"),
    (r"<html[\s>]", "缺少 <html> 根标签"),
    (r"</html>", "缺少 </html> 闭合标签"),
]

MIN_BYTES = 500


def validate(path: str):
    """返回错误列表；空列表表示通过。"""
    errors = []
    if not os.path.exists(path):
        return [f"文件不存在: {path}"]
    try:
        with open(path, "r", encoding="utf-8") as f:
            content = f.read()
    except Exception as e:  # noqa: BLE001
        return [f"无法以 UTF-8 读取: {e}"]

    # 2. 残留占位符
    leftover = re.findall(r"\{\{[^}]*\}\}", content)
    if leftover:
        uniq = sorted(set(leftover))
        errors.append(f"存在 {len(leftover)} 处未替换占位符: {uniq[:5]}")

    # 3/4. 必需标记
    for pat, msg in REQUIRED_PATTERNS:
        if not re.search(pat, content, re.IGNORECASE):
            errors.append(msg)

    # 5. 体积合理
    size = len(content.encode("utf-8"))
    if size < MIN_BYTES:
        errors.append(f"体积仅 {size} 字节（< {MIN_BYTES}），疑似空壳")

    return errors


def main() -> int:
    if len(sys.argv) < 2:
        print("用法: python scripts/validate_card.py <html> [<html> ...]")
        return 2

    overall = 0
    for p in sys.argv[1:]:
        errs = validate(p)
        if errs:
            overall = 1
            print(f"[FAIL] {p}")
            for e in errs:
                print(f"   - {e}")
        else:
            size = len(open(p, "rb").read())
            print(f"[PASS] {p} ({size} 字节, 无残留占位符, DOCTYPE/</html> 正常)")
    return overall


if __name__ == "__main__":
    sys.exit(main())
