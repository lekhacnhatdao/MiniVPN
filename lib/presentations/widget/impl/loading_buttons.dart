import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:openvpn/presentations/widget/index.dart';
import 'package:openvpn/resources/colors.dart';

class LoadingButtons extends StatelessWidget {
  const LoadingButtons({
    super.key,
    required this.isLoading,
    required this.icon,
    required this.text,
    this.backgroundColor = AppColors.accent,
    this.height = 52,
    this.onPressed,
    this.margin,
    required this.icondata,
    required this.changeUI,  this.size,

  });
  final double ? size;
  final bool isLoading;
  final bool changeUI;
  final IconData icondata;
  final Widget icon;
  final String text;
  final Color backgroundColor;
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration:  BoxDecoration(
          color:  isLoading? AppColors.icon:  changeUI ?  AppColors.icon : AppColors.connect,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: isLoading? AppColors.icon:  changeUI ?  AppColors.icon : AppColors.connect, spreadRadius: 10, blurRadius: 10)
          ]),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: Stack(
            children: [
              Container(
                height: 160,
                width: 160,
                decoration:  BoxDecoration(
                  color:isLoading? AppColors.icon:  changeUI ?  AppColors.icon : AppColors.connect,
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                top: 20,
                bottom: 20,
                child: Container(
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: isLoading? AppColors.icon:  changeUI ?  AppColors.icon : AppColors.connect,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: isLoading
                      ? Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 40))
                      : Icon(
                          icondata,
                          size: size,
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
