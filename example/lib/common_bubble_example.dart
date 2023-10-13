/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2022-04-29 17:06:50
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-10-13 11:09:35
 * @FilePath: /phoenix_selection/example/lib/common_bubble_example.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:phoenix_card/phoenix_card.dart';
import 'package:phoenix_navbar/phoenix_navbar.dart';

class BubbleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PhoenixAppBar(
        title: '气泡信息',
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '规则',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BubbleText(
              maxLines: 3,
              text: '最多显示两行文本，背景边框的圆角是4，左上角是特殊的形状，\n '
                  '文本的字号是14，颜色为深色',
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            InsertInfo(
              infoText: '推荐理由：“满五唯一”“临近地铁”“首付低”，多出折行显示，文字展开的样式文。',
            ),
            Text(
              '异常案例文案过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            InsertInfo(
              infoText:
                  '推荐理由：“满五唯一”“临近地铁”“首付低”，多出折行显示，文字展开的样式文。按钮的文案特别长按钮的文案特别长按钮的文案特别长按钮的文案特别长',
            ),
            Text(
              '异常案例文案过少',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            InsertInfo(
              infoText: '推荐理由',
            ),
            Text(
              '异常案例文案长度为0',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            InsertInfo(
              infoText: '',
            ),
          ],
        ),
      ),
    );
  }
}
