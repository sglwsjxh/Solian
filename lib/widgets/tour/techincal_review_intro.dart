import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:styled_widget/styled_widget.dart';

class TechicalReviewIntroWidget extends StatelessWidget {
  const TechicalReviewIntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, left: 20, right: 16, bottom: 12),
            child: Row(
              children: [
                Text(
                  '技术性预览',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Symbols.close),
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(minimumSize: const Size(36, 36)),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('👋').fontSize(32),
                  Text('你好呀～').fontSize(24),
                  Text('欢迎来使用 Solar Network 3.0 的技术性预览版。'),
                  const Gap(24),
                  Text('技术性预览的初衷是让我们更顺滑的将 3.0 发布出来，帮助我们一点一点的迁移数据。'),
                  const Gap(24),
                  Text('同时，既然是测试版，肯定有一系列的 Bug 和问题，请多多包涵，也欢迎积极反馈到 GitHub 上。'),
                  Text('目前帐号数据已经迁移完毕，其他数据将在未来逐渐迁移。还请耐心等待，不要重复创建以免未来数据冲突。'),
                  const Gap(24),
                  Text('最后，感谢你愿意参与技术性预览，祝你使用愉快！'),
                  const Gap(16),
                  Text('关掉这个对话框就开始探索吧！').fontSize(11),
                ],
              ).padding(horizontal: 20, vertical: 24),
            ),
          ),
        ],
      ),
    );
  }
}
