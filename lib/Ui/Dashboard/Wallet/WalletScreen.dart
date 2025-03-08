import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AddFunds.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AlarmScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtime.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyData.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/HelpSupport.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_screen.dart';
import 'package:jost_pay_wallet/Ui/promotions/socials_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double totalBalance = 0.0;

  late String deviceId;
  String selectedAccountId = "",
      selectedAccountName = "",
      selectedAccountAddress = "",
      selectedAccountPrivateAddress = "";

  bool isCalculating = false;
  bool isLoaded = false;

  double showTotalValue = 0.0;
  var trxPrivateKey = "";

  bool isNeeded = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 68),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(
                  color: themeProvider.isDarkMode()
                      ? MyColor.borderDarkColor
                      : MyColor.borderColor,
                  width: 0.9),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        dashProvider.changeBottomIndex(4);
                      },
                      child: Container(
                        width: 153,
                        padding: const EdgeInsets.only(
                          right: 12.0,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                color: themeProvider.isDarkMode()
                                    ? MyColor.borderDarkColor
                                    : MyColor.borderColor,
                                width: 0.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/avatar.png',
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Yemi Oshor',
                              style: MyStyle.tx12Black.copyWith(
                                color: themeProvider.isDarkMode()
                                    ? MyColor.mainWhiteColor
                                    : MyColor.dark01Color,
                              ),
                            ),
                            Image.asset(
                              'assets/images/arrow-right.png',
                              color: themeProvider.isDarkMode()
                                  ? MyColor.mainWhiteColor
                                  : MyColor.dark01Color,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 105.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Helpsupport()));
                            },
                            child: SvgPicture.asset(
                              'assets/images/svg/customerservice.svg',
                              colorFilter: ColorFilter.mode(
                                  themeProvider.isDarkMode()
                                      ? MyColor.mainWhiteColor
                                      : MyColor.dark01Color,
                                  BlendMode.srcIn),
                            ),
                          ),
                          //!Theme switcbing
                          GestureDetector(
                              onTap: () {
                                themeProvider.toggleTheme(
                                    themeProvider.isDarkMode() ? false : true);
                              },
                              child: SvgPicture.asset(
                                'assets/images/svg/theme.svg',
                                colorFilter: ColorFilter.mode(
                                    themeProvider.isDarkMode()
                                        ? MyColor.mainWhiteColor
                                        : MyColor.dark01Color,
                                    BlendMode.srcIn),
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AlarmScreen()));
                            },
                            child: Image.asset("assets/images/alarm.png",
                                height: 23,
                                width: 22,
                                color: themeProvider.isDarkMode()
                                    ? MyColor.mainWhiteColor
                                    : null //MyColor.dark01Color,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 24.0, right: 12.0),
                  decoration: BoxDecoration(
                      // color: MyColor.lightGreenColor,
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(
                          color: themeProvider.isDarkMode()
                              ? MyColor.borderDarkColor
                              : MyColor.borderColor,
                          width: 0.9),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/ng-flag.png',
                                  width: 24.8,
                                  height: 24.8,
                                ),
                                const SizedBox(width: 8),
                                Text('Balance',
                                    style: MyStyle.tx16Gray.copyWith(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary))
                              ],
                            ),
                          ),
                          Container(
                            height: 41,
                            width: 41,
                            // padding: const EdgeInsets.all(13),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                shape: BoxShape.circle),
                            child: Image.asset(
                              "assets/images/refresh.png",
                              height: 24,
                              width: 24,
                              color: MyColor.splashBtn,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₦ 10,000.00',
                            style: MyStyle.tx28Black.copyWith(
                                fontSize: 26.sp,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                          SvgPicture.asset('assets/images/svg/moneybag.svg'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddFunds()));
                                },
                                borderRadius: BorderRadius.circular(
                                    12.3), // Optional: to match the container's border radius
                                child: Container(
                                  width: 54,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColor.greenColor,
                                      width: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(12.3),
                                  ),
                                  child: Image.asset(
                                    'assets/images/dashboard/money-send-circle.png',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Add funds',
                                  style: MyStyle.tx12Black.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BuyAirtime()));
                                },
                                borderRadius: BorderRadius.circular(12.3),
                                child: Container(
                                  width: 54,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColor.greenColor,
                                      width: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(12.3),
                                  ),
                                  child: Image.asset(
                                    'assets/images/dashboard/smart-phone-01.png',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Buy Airtime',
                                  style: MyStyle.tx12Black.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Pay4meScreen())),
                                  child: Container(
                                    width: 54,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColor.greenColor,
                                        width: 0.9,
                                      ),
                                      borderRadius: BorderRadius.circular(12.3),
                                    ),
                                    child: Image.asset(
                                      'assets/images/dashboard/bitcoin-03.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Pay4me',
                                  style: MyStyle.tx12Black.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => dashProvider.changeBottomIndex(1),
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const Services())),
                                child: Container(
                                  width: 54,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColor.greenColor,
                                      width: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(12.3),
                                  ),
                                  child: Image.asset(
                                    'assets/images/dashboard/more-vertical-circle-01.png',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('More',
                                  style: MyStyle.tx12Black.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Visibility(
            visible: dashProvider.promotionBanner,
            child: Container(
              padding: const EdgeInsets.only(left: 26, top: 11, right: 26),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Are you the next winner? 🎉',
                              style: MyStyle.tx28Black.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text("Don't miss out on this incredible",
                                style: MyStyle.tx12Black.copyWith(
                                    color: themeProvider.isDarkMode()
                                        ? const Color(0XFFCBD2EB)
                                        : const Color(0xff30333A)))
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text("opportunity to win big!",
                                style: MyStyle.tx12Black.copyWith(
                                    color: themeProvider.isDarkMode()
                                        ? const Color(0XFFCBD2EB)
                                        : const Color(0xff30333A)))
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                dashProvider.changeBottomIndex(3);
                              },
                              child: Container(
                                // width: 66,
                                height: 25,
                                margin: EdgeInsets.only(bottom: 12.h),
                                decoration: BoxDecoration(
                                    color: MyColor.greenColor,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                child: const Text(
                                  'Learn more',
                                  style: MyStyle.tx8White,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                dashProvider.hidePromotionbanner(false);
                              },
                              child: Container(
                                // width: 66,
                                height: 25,
                                margin: EdgeInsets.only(bottom: 12.h),
                                decoration: BoxDecoration(
                                    color: MyColor.greenColor,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                child: const Text(
                                  'Close  X',
                                  style: MyStyle.tx8White,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      child: Transform.translate(
                    offset: const Offset(0.0,
                        12.0), // Translate 10 pixels to the right and 20 pixels down
                    child: Image.asset(
                      'assets/images/dashboard/gift.png',
                      width: 71,
                      height: 120,
                    ),
                  ))
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 24),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Services',
                                style: MyStyle.tx28Black.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () =>
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const BuyAirtime())),
                                            child: Container(
                                              width: 61,
                                              height: 56.5,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                boxShadow: const [
                                                  MyStyle.widgetShadow,
                                                ],
                                              ),
                                              child: Image.asset(
                                                'assets/images/dashboard/smartphone-wifi.png',
                                                height: 33.r,
                                                width: 33.r,
                                              ),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Text('Buy Airtime',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BuyData())),
                                          child: Container(
                                            width: 61,
                                            height: 56.5,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              boxShadow: const [
                                                MyStyle.widgetShadow,
                                              ],
                                            ),
                                            child: Image.asset(
                                              'assets/images/dashboard/smart-phone-01.png',
                                              height: 33.r,
                                              width: 33.r,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Text('Buy Data',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SocialsScreen())),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 61,
                                            height: 56.5,
                                            padding: EdgeInsets.all(16.r),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              boxShadow: const [
                                                MyStyle.widgetShadow,
                                              ],
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/svg/socialBoost.svg',
                                              height: 33.r,
                                              width: 33.r,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text('Social Boost',
                                              style: MyStyle.tx12Black.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              dashProvider.changeBottomIndex(1),
                                          child: Container(
                                            width: 61,
                                            height: 56.5,
                                            padding: EdgeInsets.all(16.r),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              boxShadow: const [
                                                MyStyle.widgetShadow,
                                              ],
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/svg/viewAll.svg',
                                              height: 33.r,
                                              width: 33.r,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Text('View all',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'History',
                              style: MyStyle.tx14Grey.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            ),
                          ),
                          // const SizedBox(height: 10),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                const HistoryCard(),
                            shrinkWrap: true,
                            itemCount: 5,
                          ),
                          const SizedBox(height: 80),
                        ],
                      ))))
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 41.r,
        width: 41.r,
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
            color: themeProvider.isDarkMode()
                ? const Color(0XFF171717)
                : const Color(0XFFF4F5F6),
            shape: BoxShape.circle),
        child: SvgPicture.asset('assets/images/svg/money.svg'),
      ),
      title: Text(
        'Fiverr',
        style: MyStyle.tx14Grey.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: themeProvider.isDarkMode()
                ? const Color(0XFFCBD2EB)
                : const Color(0xff30333A)),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'N 26, 000.00',
            style: MyStyle.tx14Grey.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: themeProvider.isDarkMode()
                    ? const Color(0XFFCBD2EB)
                    : const Color(0xff30333A)),
          ),
          Text(
            'Successful',
            style: MyStyle.tx14Grey.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 11.sp,
                color: const Color(0XFF027A48)),
          ),
        ],
      ),
      subtitle: Text(
        'June 30th, 11: 37',
        style: MyStyle.tx14Grey.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: themeProvider.isDarkMode()
                ? const Color(0XFFCBD2EB)
                : const Color(0xff30333A)),
      ),
    );
  }
}
