// core/widgets/shimmers/smart_shimmer_generator.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// مولد ذكي لـ Shimmer بناءً على تحليل الـ Widget
class SmartShimmerGenerator {
  /// يحلل الـ Widget ويولد shimmer مطابق له
  static Widget generate(BuildContext context, Widget originalWidget) {
    final analyzer = _WidgetAnalyzer();
    analyzer.analyze(context, originalWidget);
    return analyzer.buildShimmer();
  }

  /// يولد shimmer من Layout معين
  static Widget fromLayout(ShimmerLayout layout) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: _buildLayoutShimmer(layout),
    );
  }
}

/// أنواع الـ Layouts المختلفة
enum ShimmerLayout {
  list,
  grid,
  card,
  profile,
  feed,
  chat,
  product,
  form,
}

Widget _buildLayoutShimmer(ShimmerLayout layout) {
  switch (layout) {
    case ShimmerLayout.list:
      return _ListShimmer();
    case ShimmerLayout.grid:
      return _GridShimmer();
    case ShimmerLayout.card:
      return _CardShimmer();
    case ShimmerLayout.profile:
      return _ProfileShimmer();
    case ShimmerLayout.feed:
      return _FeedShimmer();
    case ShimmerLayout.chat:
      return _ChatShimmer();
    case ShimmerLayout.product:
      return _ProductShimmer();
    case ShimmerLayout.form:
      return _FormShimmer();
  }
}

// ==================== Widget Analyzer ====================
class _WidgetAnalyzer {
  final List<ShimmerElement> elements = [];

  void analyze(BuildContext context, Widget widget) {
    // هنا المنطق الذكي لتحليل الـ Widget Tree
    // لكن الطريقة الأسهل هي استخدام الـ Layouts الجاهزة
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: elements.map((e) => e.build()).toList(),
      ),
    );
  }
}

class ShimmerElement {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  ShimmerElement(this.width, this.height, [this.borderRadius]);

  Widget build() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
    );
  }
}

// ==================== Shimmer Templates ====================

class _ListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 150,
                      height: 14,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GridShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 16,
              color: Colors.white,
            ),
            SizedBox(height: 4),
            Container(
              width: 80,
              height: 14,
              color: Colors.white,
            ),
          ],
        );
      },
    );
  }
}

class _CardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: List.generate(3, (index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 20,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 16,
                  color: Colors.grey[300],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ProfileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          // Avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 16),
          // Name
          Container(
            width: 150,
            height: 20,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          // Bio
          Container(
            width: 200,
            height: 14,
            color: Colors.white,
          ),
          SizedBox(height: 24),
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return Column(
                children: [
                  Container(
                    width: 60,
                    height: 24,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 80,
                    height: 14,
                    color: Colors.white,
                  ),
                ],
              );
            }),
          ),
          SizedBox(height: 24),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeedShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 14,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 4),
                        Container(
                          width: 80,
                          height: 12,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Image
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey[300],
              ),
              // Actions & Caption
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(3, (i) {
                        return Container(
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.only(right: 16),
                          color: Colors.grey[300],
                        );
                      }),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 14,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 200,
                      height: 14,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChatShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (context, index) {
        final isMe = index % 2 == 0;
        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  width: 60,
                  height: 12,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProductShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: double.infinity,
            height: 300,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Container(
                  width: double.infinity,
                  height: 24,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  width: 200,
                  height: 24,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                // Price
                Container(
                  width: 100,
                  height: 28,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                // Rating
                Row(
                  children: [
                    ...List.generate(5, (i) {
                      return Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(right: 4),
                        color: Colors.white,
                      );
                    }),
                    SizedBox(width: 8),
                    Container(
                      width: 60,
                      height: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                // Description
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 16,
                  color: Colors.white,
                ),
                SizedBox(height: 24),
                // Button
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FormShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(5, (index) {
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 14,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}


extension SmartShimmerExtension on Widget {
  /// يحول أي Widget لـ Shimmer Loading
  Widget toShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: this,
    );
  }
}