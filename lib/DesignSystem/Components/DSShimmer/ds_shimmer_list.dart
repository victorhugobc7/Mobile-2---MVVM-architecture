import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../shared/colors.dart';
import '../../shared/spacing.dart';

class DSShimmerList extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const DSShimmerList._({
    required this.itemCount,
    required this.itemBuilder,
  });

  static Widget instantiate({
    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
  }) {
    return DSShimmerList._(itemCount: itemCount, itemBuilder: itemBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: gray_200,
      highlightColor: gray_100,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: doubleXS),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

/// Pre-built shimmer skeleton for post cards
class PostCardShimmer extends StatelessWidget {
  const PostCardShimmer._();

  static Widget instantiate() {
    return const PostCardShimmer._();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: doubleXS),
      padding: EdgeInsets.all(small),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: gray_200,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: extraSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 14,
                      color: gray_200,
                    ),
                    SizedBox(height: tripleXS),
                    Container(
                      width: 100,
                      height: 12,
                      color: gray_200,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: small),
          Container(
            width: double.infinity,
            height: 14,
            color: gray_200,
          ),
          SizedBox(height: doubleXS),
          Container(
            width: double.infinity,
            height: 14,
            color: gray_200,
          ),
          SizedBox(height: doubleXS),
          Container(
            width: 200,
            height: 14,
            color: gray_200,
          ),
          SizedBox(height: small),
          Container(
            width: double.infinity,
            height: 200,
            color: gray_200,
          ),
        ],
      ),
    );
  }
}

/// Pre-built shimmer skeleton for job cards
class JobCardShimmer extends StatelessWidget {
  const JobCardShimmer._();

  static Widget instantiate() {
    return const JobCardShimmer._();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: small),
      child: Padding(
        padding: EdgeInsets.all(small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: gray_200,
                    borderRadius: BorderRadius.circular(doubleXS),
                  ),
                ),
                SizedBox(width: extraSmall),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        height: 16,
                        color: gray_200,
                      ),
                      SizedBox(height: tripleXS),
                      Container(
                        width: 120,
                        height: 14,
                        color: gray_200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: doubleXS),
            Container(
              width: 150,
              height: 12,
              color: gray_200,
            ),
            SizedBox(height: doubleXS),
            Container(
              width: 100,
              height: 12,
              color: gray_200,
            ),
          ],
        ),
      ),
    );
  }
}
