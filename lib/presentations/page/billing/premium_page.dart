import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/route/app_router.gr.dart';
import 'package:openvpn/presentations/widget/index.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/strings.dart';

@RoutePage()
class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // SizedBox(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   child: Image.asset(
        //     Assets.images.imageBackground.path,
        //     fit: BoxFit.fill,
        //   ),
        // ),
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const AppTitleText(text: Strings.upgradePremium),
          ),
          body: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return Column(
                children: [
                  ShadowContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 24) +
                        const EdgeInsets.only(top: 80),
                    height: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: const AppLabelText(
                            text: Strings.benefitsOfThePremium,
                            color: AppColors.colorYellow,
                          ),
                          onTap: () {
                            AutoRouter.of(context).push(const ShopRoute());
                          },
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                decoration: const BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppBodyText(text: Strings.removeAds),
                                  AppBodyText(text: Strings.unlockAllPremium),
                                  AppBodyText(
                                    text: Strings.superFastServer,
                                  ),
                                  AppBodyText(text: Strings.customerSupport),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
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
                  )
                ],
              );
            },
          ),
        )
      ],
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
}
