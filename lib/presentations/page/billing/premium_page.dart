import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/route/app_router.gr.dart';
import 'package:openvpn/presentations/widget/index.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/icondata.dart';
import 'package:openvpn/resources/strings.dart';
import 'package:openvpn/resources/theme.dart';
import 'package:openvpn/utils/config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  final controller = CarouselController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int activeindex = 0;
  List image = [
    'assets/images/Group40.png',
    'assets/images/Group41.png',
    'assets/images/Group42.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          Config.appName,
          style: CustomTheme.textTheme.labelLarge
              ?.copyWith(color: AppColors.icon, fontSize: 20),
        ),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: image.length,
                  options: CarouselOptions(
               
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) =>
                        setState(() => activeindex = index),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Sliderimages(image[index], index);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                buildIndicator(activeindex, image.length),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Unlock all servers',
                  style: CustomTheme.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Global servers with high-quality,\n super-fast connections',
                  textAlign: TextAlign.center,
                  style: CustomTheme.textTheme.labelLarge?.copyWith(),
                ),
                const SizedBox(
                  height: 33,
                ),
                Divider(
                  color: const Color(0xff262626).withOpacity(0.5),
                ),
                const SizedBox(
                  height: 33,
                ),
                Text(
                  'Choose your Plan',
                  style: CustomTheme.textTheme.labelLarge
                      ?.copyWith(color: AppColors.icon, fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Unlimited, make a difference',
                  style: CustomTheme.textTheme.labelLarge?.copyWith(),
                ),
                const SizedBox(
                  height: 25,
                ),
                _buildSubscriptionItem(state.subscriptions, state),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16) +
                      const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      ...state.subscriptions.take(3).map(_buildItem),
                      const SizedBox(height: 8),
                      AppButtons(
                        text: Strings.getPremiumNow,
                        onPressed: () async {
                          await context.read<AppCubit>().subscribe();
                        },
                      )
                    ],
                  ),
                ),
                Container(
                   margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Subscription Rules:',
                          style: CustomTheme.textTheme.labelLarge?.copyWith())),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        '1. Apple will charge your iTunes account for the '
                        'subscription on the last day of the trial.',
                        style: CustomTheme.textTheme.labelLarge?.copyWith(),
                      ),
                      Text(
                          '2. After you subscribe, you can manage your'
                          ' subscriptions'
                          ' in the Apple ID of the device you are using.',
                          style: CustomTheme.textTheme.labelLarge?.copyWith()),
                      Text(
                          '3. Your subscription will automatically renew unless'
                          ' it is canceled at least 24 hours before the deadline'
                          ' of your current membership.',
                          style: CustomTheme.textTheme.labelLarge?.copyWith()),
                      Text(
                          '4. If you cancel your subscription during the trial'
                          ' period, you will not be charged any fees, but you '
                          'may not be able to use the service right away.',
                          style: CustomTheme.textTheme.labelLarge?.copyWith()),
                    ],
                  ),
                )
                // ShadowContainer(
                //   margin: const EdgeInsets.symmetric(horizontal: 24) +
                //       const EdgeInsets.only(top: 80),
                //   height: 180,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       InkWell(
                //         child: const AppLabelText(
                //           text: Strings.benefitsOfThePremium,
                //           color: AppColors.colorYellow,
                //         ),
                //         onTap: () {
                //           AutoRouter.of(context).push(const ShopRoute());
                //         },
                //       ),
                //       const SizedBox(height: 16),
                //       Expanded(
                //         child: Row(
                //           children: [
                //             Container(
                //               width: 4,
                //               decoration: const BoxDecoration(
                //                 color: AppColors.accent,
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(10)),
                //               ),
                //             ),
                //             const SizedBox(width: 8),
                //             const Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               children: [
                //                 AppBodyText(text: Strings.removeAds),
                //                 AppBodyText(text: Strings.unlockAllPremium),
                //                 AppBodyText(
                //                   text: Strings.superFastServer,
                //                 ),
                //                 AppBodyText(text: Strings.customerSupport),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(ProductDetails e) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            AppRadioButtons(
              title: e.title.split('(').firstOrNull ?? '',
              summary: e.price,
              isChecked: state.selectedSubscription?.id == e.id,
              onPressed: () {
                context.read<AppCubit>().setSubscription(e);
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget buildIndicator(
    int activeindex,
    int count,
  ) {
    return AnimatedSmoothIndicator(
      activeIndex: activeindex,
      count: count,
      onDotClicked: (index) {
        print(index);
        setState(() {
          controller.animateToPage(index);
        });
      },
      effect: WormEffect(
          activeDotColor: AppColors.icon,
          spacing: 15,
          dotHeight: 10,
          dotWidth: 10,
          dotColor: const Color(0xff303030).withOpacity(0.85)),
    );
  }

  Widget _buildSubscriptionItem(
      List<ProductDetails> subscriptions, AppState state) {
    if (subscriptions.isEmpty) {
      // If subscriptions list is empty, provide default values for display
      subscriptions = [
        ProductDetails(
          id: 'default_id_1',
          title: 'Remove ads 1 year',
          description: 'Default Description 1',
          price: '100.000đ',
          rawPrice: 100.00,
          currencyCode: 'VND',
        ),
      ];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: subscriptions.take(3).map((e) {
        return GestureDetector(
          onTap: () {
            context.read<AppCubit>().setSubscription(e);
          },
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xff303030).withOpacity(0.7),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  width: 1,
                  color: state.selectedSubscription?.id == e.id
                      ? AppColors.icon
                      : Colors.transparent,
                )),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                state.selectedSubscription?.id == e.id
                    ? Text(
                        '${e.title.split('(').firstOrNull ?? ''}',
                        style: TextStyle(color: AppColors.icon),
                      )
                    : AppLabelText(
                        text: e.title.split('(').firstOrNull ?? '',
                        size: 15,
                        color: AppColors.primary),
                const SizedBox(width: 10),
                state.selectedSubscription?.id == e.id
                    ? Text(
                        '${e.price}',
                        style: TextStyle(color: AppColors.icon),
                      )
                    : AppTitleText(
                        size: 15,
                        text: e.price,
                        color: AppColors.primary,
                      ),
                const SizedBox(width: 5),
                //   Assets.icons.icCrown.svg()
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

Sliderimages(String images, int index) {
  return Container(
    color: Colors.black,
    child: Image.asset(images),
  );
}

  //  Expanded(
  //                     child: AppBar(title: TabBarView(children:[ 
  //                       Image.asset('assets/images/Group40.png'),
  //                       Image.asset('assets/images/Group41.png'),
  //                       Image.asset('assets/images/Group42.png'),
                                
  //                     ]),
  //                     bottom: const TabBar(tabs: [
  //                       Icon(Icons.brightness_1_rounded),
  //                        Icon(Icons.brightness_1_rounded),
  //                         Icon(Icons.brightness_1_rounded),
  //                     ]),),
  //                   )