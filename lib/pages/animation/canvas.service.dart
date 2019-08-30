
import 'package:flutter/material.dart';
import 'dart:math';
/**
 * 绘制网格路径
 *
 * @param step    小正方形边长
 * @param winSize 画布尺寸
 */
Path gridPath(int step, Size winSize) {
  Path path = new Path();

  for (int i = 0; i < winSize.height / step + 1; i++) {
    path.moveTo(0, step * i.toDouble());
    path.lineTo(winSize.width, step * i.toDouble());
  }

  for (int i = 0; i < winSize.width / step + 1; i++) {
    path.moveTo(step * i.toDouble(), 0);
    path.lineTo(step * i.toDouble(), winSize.height);
  }
  return path;
}


/**
 * n角星路径
 *
 * @param num 几角星
 * @param R   外接圆半径
 * @param r   内接圆半径
 * @return n角星路径
 */
Path nStarPath({int num, double R, double r}) {
  Path path = new Path();
  double perDeg = 360 / num; //尖角的度数
  double degA = perDeg / 2 / 2;
  double degB = 360 / (num - 1) / 2 - degA / 2 + degA;

  path.moveTo(cos(_rad(degA)) * R, (-sin(_rad(degA)) * R));
  for (int i = 0; i < num; i++) {
    path.lineTo(
        cos(_rad(degA + perDeg * i)) * R, -sin(_rad(degA + perDeg * i)) * R);
    path.lineTo(
        cos(_rad(degB + perDeg * i)) * r, -sin(_rad(degB + perDeg * i)) * r);
  }
  path.close();
  return path;
}

double _rad(double deg) {
  return deg * pi / 180;
}


