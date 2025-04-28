---
# YAML Front Matter to define variables for the cover page
title: "实验报告"
author: "Yusan" # Pandoc uses this, maybe define student_name below too for clarity
date: "2025年10月13日" # Specific date, overrides \today

# Variables matching the template ($variable$)
logo: "figure/badge.pdf" # Path to your logo file (relative to md file)

institution: "中山大学"
department: "计算机学院"
course: "动漫鉴赏"
experiment_title: "为美好实验献上报告"
student_name: "张三"
student_id: "2024001234"
# class_name: "软件工程1班" # Uncomment and fill if you added class_name to template
teacher_name: "李四 教授"

# Pandoc configuration
pdf-engine: xelatex          # Essential for Chinese characters
template: my_template.latex # Your *main* template file, which should include the cover page logic
# OR if report_cover.latex is *separate* and not included in main template:
# include-before-body: report_cover.latex # Include the cover page before the main content
header-includes:
  - \usepackage{graphicx}  # <--- 确保加载 graphicx 宏包
  - 
toc: false                    # Optional: Generate Table of Contents after cover
toc-depth: 3
documentclass: ctexart       # Use ctexart for good Chinese defaults
mainfont: "SimSun"           # Example Chinese font (make sure it's installed)
sansfont: "SimHei"
monofont: "SimSun"   # Example Chinese-friendly mono font

---

# 实验内容

这里开始你的 Markdown 正文内容...

## 实验目的

...


| B3  | B2  | B1  | B0  | G3  | G2  | G1  | G0  |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   |
| 0   | 0   | 0   | 1   | 0   | 0   | 0   | 1   |
| 0   | 0   | 1   | 0   | 0   | 0   | 1   | 1   |
| 0   | 0   | 1   | 1   | 0   | 0   | 1   | 0   |
| 0   | 1   | 0   | 0   | 0   | 1   | 1   | 0   |
| 0   | 1   | 0   | 1   | 0   | 1   | 1   | 1   |
| 0   | 1   | 1   | 0   | 0   | 1   | 0   | 1   |
| 0   | 1   | 1   | 1   | 0   | 1   | 0   | 0   |
| 1   | 0   | 0   | 0   | 1   | 1   | 0   | 0   |
| 1   | 0   | 0   | 1   | 1   | 1   | 0   | 1   |
| 1   | 0   | 1   | 0   | 1   | 1   | 1   | 1   |
| 1   | 0   | 1   | 1   | 1   | 1   | 1   | 0   |
| 1   | 1   | 0   | 0   | 1   | 0   | 1   | 0   |
| 1   | 1   | 0   | 1   | 1   | 0   | 1   | 1   |
| 1   | 1   | 1   | 0   | 1   | 0   | 0   | 1   |
| 1   | 1   | 1   | 1   | 1   | 0   | 0   | 0   |

### 枚举测试
- one
- two
- three

```c
    printf("Hello World\n");
```

- 随便写点

![这是一张需要精确放置的图片说明](images/1.png){placement=H width=75% #fig:important}

- 惠惠