import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/core.dart';

const _devam = "Devam";
const _gec = "Geç";

const _title1 = "Sağlığınız\nTek Bir Uygulamada";
const _desc1 = "Sağlınızı korumak için yenilikçi ve teknolojik bir yaklaşım.";

const _title2 = "Anında\nRandevu Oluşturun";
const _desc2 =
    "Dilediğiniz sağlık uzmanından hastane ve online randevu alabilirsiniz.";

const _title3 = "Kişiselleştirilmiş\nGrafikler";
const _desc3 =
    "Diyabet, tansiyon ve kilo takibinizi uzmanlar eşliğinde yönetebilirsiniz.";

const _title4 = "Önemli Anları Beraber\nTakip Edelim";
const _desc4 =
    "Günlük hatırlatıcılar ve anlık bildirimler sayesinde sağlığınızı korumak için size yardımcı olacağız.";

const _title5 = "One Dose Health";
const _desc5 = "Sağlığınız Parmaklarınızın Ucunda";

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  IntroductionScreenState createState() => IntroductionScreenState();
}

class IntroductionScreenState extends State<IntroductionScreen> {
  ValueNotifier<bool> valueNotifier = ValueNotifier(true);

  final itemCount = 5;

  static List<IntroductionDto> dataList = <IntroductionDto>[
    IntroductionDto(
      animationPath: R.image.riveGiris,
      title: _title1,
      description: _desc1,
      isLast: false,
    ),
    IntroductionDto(
      animationPath: R.image.riveRandevu,
      title: _title2,
      description: _desc2,
      isLast: false,
    ),
    IntroductionDto(
      animationPath: R.image.riveSaglikTakibi,
      title: _title3,
      description: _desc3,
      isLast: false,
    ),
    IntroductionDto(
      animationPath: R.image.riveReminer,
      title: _title4,
      description: _desc4,
      isLast: false,
    ),
    IntroductionDto(
      animationPath: R.image.riveReminer,
      title: _title5,
      description: _desc5,
      isLast: true,
    ),
  ];

  late PageController _pageController;
  int currentPage = 0;

  void _onScroll() {
    if (_pageController.page!.toInt() == _pageController.page) {
      if (mounted) {
        setState(() {
          currentPage = _pageController.page!.toInt();
          if (currentPage < itemCount - 1) {
            valueNotifier.value = true;
          } else {
            valueNotifier.value = false;
          }
        });
      }
    }
  }

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      keepPage: false,
    );
    _pageController.addListener(_onScroll);

    getIt<ISharedPreferencesManager>().setBool(
      SharedPreferencesKeys.firstLaunch,
      true,
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RbioDarkStatusBar(
      child: Scaffold(
        backgroundColor: getIt<ITheme>().cardBackgroundColor,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              //
              Positioned.fill(
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    if (!dataList[index].isLast) {
                      return IntroCard(
                        item: dataList[index],
                        openScreen: openScreen,
                      );
                    } else {
                      return AnimatedIntroCard(
                        item: dataList[index],
                        valueNotifier: valueNotifier,
                        openScreen: openScreen,
                      );
                    }
                  },
                ),
              ),

              //
              Align(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: itemCount,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 16,
                    activeDotColor: getIt<ITheme>().mainColor,
                    dotColor: getIt<ITheme>().grey.withOpacity(0.5),
                  ),
                ),
              ),

              //
              Align(
                alignment: Alignment.bottomCenter,
                child: ValueListenableBuilder<bool>(
                  valueListenable: valueNotifier,
                  builder: (BuildContext context, bool isLast, Widget? child) {
                    return RbioSwitcher(
                      showFirstChild: isLast,
                      child1: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            //
                            Expanded(
                              child: RbioElevatedButton(
                                title: _gec,
                                onTap: () {
                                  valueNotifier.value = true;
                                  _pageController.animateToPage(
                                    itemCount - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                backColor: getIt<ITheme>().cardBackgroundColor,
                                showElevation: false,
                                textColor: getIt<ITheme>().mainColor,
                              ),
                            ),

                            //
                            Expanded(
                              child: RbioElevatedButton(
                                showElevation: false,
                                title: _devam,
                                onTap: () {
                                  if (currentPage != itemCount - 1) {
                                    _pageController.animateToPage(
                                      currentPage + 1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  } else {
                                    //
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      child2: const SizedBox(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openScreen(String route) async {
    Atom.to(
      route,
      isReplacement: true,
    );
  }
}

class AnimatedIntroCard extends StatelessWidget {
  final IntroductionDto item;
  final Future<void> Function(String route) openScreen;
  final ValueNotifier<bool> valueNotifier;

  const AnimatedIntroCard({
    Key? key,
    required this.item,
    required this.openScreen,
    required this.valueNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //
          SizedBox(
            height: Atom.height * 0.4,
            child: SvgPicture.asset(
              R.image.odhLogoSvg,
            ),
          ),

          //
          Expanded(
            child: ValueListenableBuilder<bool>(
                valueListenable: valueNotifier,
                builder: (BuildContext context, bool isLast, Widget? child) {
                  return RbioSwitcher(
                    showFirstChild: isLast,
                    duration: const Duration(seconds: 1),
                    child1: const SizedBox(),
                    child2: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //
                        const Spacer(),
                        R.sizes.hSizer8,

                        //
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: context.xHeadline1.copyWith(
                            color: getIt<ITheme>().mainColor,
                            fontSize: context.xHeadline1.fontSize! * 1.5,
                            fontWeight: FontWeight.bold,
                            height: 1.35,
                          ),
                        ),

                        //
                        R.sizes.hSizer8,

                        //
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: context.xHeadline2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        //
                        const Spacer(),

                        //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: RbioElevatedButton(
                            showElevation: false,
                            fontWeight: FontWeight.bold,
                            title: LocaleProvider.current.sign_up,
                            onTap: () async {
                              await openScreen(PagePaths.registerStep1Intro);
                            },
                          ),
                        ),

                        //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: RbioElevatedButton(
                            backColor: getIt<ITheme>().cardBackgroundColor,
                            textColor: getIt<ITheme>().mainColor,
                            showElevation: false,
                            fontWeight: FontWeight.bold,
                            title: LocaleProvider.current.login,
                            onTap: () async {
                              await openScreen(PagePaths.login);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class IntroCard extends StatelessWidget {
  final IntroductionDto item;
  final Future<void> Function(String route) openScreen;

  const IntroCard({
    Key? key,
    required this.item,
    required this.openScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //
          SizedBox(
            height: Atom.height * 0.4,
            child: item.isLast
                ? Container(color: getIt<ITheme>().mainColor)
                : RiveAnimation.asset(
                    item.animationPath,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.bottomCenter,
                  ),
          ),

          //
          const Spacer(flex: 3),

          //
          Text(
            item.title,
            style: context.xHeadline1.copyWith(
              fontSize: context.xHeadline1.fontSize! * 1.25,
              fontWeight: FontWeight.bold,
              height: 1.35,
            ),
          ),

          //
          R.sizes.hSizer16,

          //
          Text(
            item.description,
            style: context.xHeadline2.copyWith(),
          ),

          //
          const Spacer(flex: 6),
        ],
      ),
    );
  }
}

class IntroductionDto {
  final String animationPath;
  final String title;
  final String description;
  final bool isLast;

  IntroductionDto({
    required this.animationPath,
    required this.title,
    required this.description,
    required this.isLast,
  });
}
