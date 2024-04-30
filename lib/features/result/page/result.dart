import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mottaina_eat/components/mainContainer.dart';
import 'package:mottaina_eat/components/primary_button.dart';
import 'package:mottaina_eat/features/result/view_model.dart';
import 'package:mottaina_eat/style/colors.dart';
import 'package:mottaina_eat/style/styles.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({
    Key? key,
    required this.resultsBool,
    required this.resultsId,
    required this.quizLength,
  }) : super(key: key);

  final List<bool> resultsBool;
  final List<int> resultsId;
  final int quizLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resultViewModelProvider);
    return state.when(
      data: (data) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://lh3.googleusercontent.com/pw/AP1GczP6EbprN0oQZbyhWUx5P5lix3vQyUc_CN6LgsTfcc0mHWdBwdK6wNKcbUMu8Yy6wlu3sGkJVQHYTGheaj5SJo3f0L8GEEA8-8fQ-ODUlZi7wna1Sefri3ne2IBBFTaI1wTcuKulzKA5CaeVFIy4qUTPeQ=w598-h846-s-no-gm?authuser=0'),
            fit: BoxFit.cover,
          ),
        ),
        child: PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorName.eatOrange,
            ),
            body: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 240),
                      child: mainContainer(
                        height: MediaQuery.of(context).size.height * 0.3,
                        children: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '10問中',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '問正解',
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: ColorName.black2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              '正答率 %',
                              style: TextStyle(
                                color: ColorName.black2,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            PrimaryButton(
                              backgroundColor:
                                  ColorName.eatOrange.withOpacity(0.8),
                              onPressed: () => ref
                                  .read(resultViewModelProvider.notifier)
                                  .navigateToTopPage(context),
                              text: 'ホームに戻る',
                              width: MediaQuery.of(context).size.width * 0.8,
                              borderRaius: 30,
                              height: 40,
                              elevation: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          color: ColorName.white.withOpacity(0.8),
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child: const Center(child: Text('正誤')),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          color: ColorName.white.withOpacity(0.8),
                          width: MediaQuery.of(context).size.width * 0.63,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '問題',
                                style: Styles.fourteen,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          color: ColorName.white.withOpacity(0.8),
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child: const Center(
                            child: Text(
                              'みんなの正答率',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: quizLength,
                    itemBuilder: (context, index) {
                      final int incorrectCount =
                          data.quizzes[resultsId[index]].incorrectCount ?? 0;
                      final int correctCount =
                          data.quizzes[resultsId[index]].correctCount ?? 0;
                      final int totalCount = incorrectCount + correctCount;
                      final int correctPercent = (totalCount != 0)
                          ? (correctCount / totalCount * 100).toInt()
                          : 0;
                      final int incorrectPercent = (totalCount != 0)
                          ? (incorrectCount / totalCount * 100).toInt()
                          : 0;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                color: ColorName.white.withOpacity(0.8),
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                child: resultsBool[index] == true
                                    ? Center(
                                        child: Icon(
                                          Icons.circle_outlined,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          color: ColorName.trueRed,
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.clear,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          color: ColorName.falseBlue,
                                        ),
                                      ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                color: ColorName.white.withOpacity(0.8),
                                width: MediaQuery.of(context).size.width * 0.63,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${index + 1}問目 ${data.quizzes[resultsId[index]].quizStatement}',
                                      maxLines: 2,
                                      style: Styles.fourteen,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                color: ColorName.white.withOpacity(0.8),
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      child: PieChart(
                                        PieChartData(
                                          startDegreeOffset: -90,
                                          sections: [
                                            PieChartSectionData(
                                              showTitle: false,
                                              value:
                                                  (correctPercent).toDouble(),
                                              color: Colors.deepOrangeAccent,
                                            ),
                                            PieChartSectionData(
                                              showTitle: false,
                                              value:
                                                  (incorrectPercent).toDouble(),
                                              color: ColorName.greyBase,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        '$correctPercent%',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      error: (error, StackTrace) => const SizedBox(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
