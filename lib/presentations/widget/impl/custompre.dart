import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openvpn/presentations/page/billing/premium_page.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/theme.dart';

class CustomPre extends StatefulWidget {
  const CustomPre({super.key});

  @override
  State<CustomPre> createState() => _CustomPreState();
}

class _CustomPreState extends State<CustomPre> {
  @override
  Widget build(BuildContext context) {
    return   InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => PremiumPage()));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/earth.png',
                              ),
                              fit: BoxFit.cover)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          Image.asset('assets/images/crown.png'),SizedBox(width: 10,),
                           Column(
                            children: [
                              
                              Text('Upgrade to Premium' , style: CustomTheme.textTheme.labelLarge?.copyWith(),),
                              Text('Start 3-days free trial',  style: CustomTheme.textTheme.labelLarge?.copyWith(
                                fontSize: 12
                              ),)
                            ],
                          ),
                          const Spacer(),
                           Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: AppColors.icon
                            ),
                            child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)) 
                        ],
                      ),
                    )
                  ) ;
  }
}