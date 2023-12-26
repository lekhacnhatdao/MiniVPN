import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openvpn/resources/theme.dart';

class CustomData extends StatefulWidget {
  const CustomData({super.key,required this.icon,required this.text,required this.data, this.color});
final IconData  icon;
final String   text;
final String data;
final Color ? color;
  @override
  State<CustomData> createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Icon(widget.icon, color: widget.color),
          SizedBox(width: 5,),
          Text(widget.text, style: CustomTheme.textTheme.labelLarge?.copyWith(
            
          ),)
        ],),
        SizedBox(height: 5,),
        Text(widget.data, style: CustomTheme.textTheme.labelLarge?.copyWith(
            
          ),),

      ],
    );
  }
}