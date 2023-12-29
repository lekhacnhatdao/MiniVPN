import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:openvpn/di/components/app_component.dart';
import 'package:openvpn/domain/model/history/history_model.dart';
import 'package:openvpn/local/app_db.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/widget/impl/app_body_text.dart';


import 'package:openvpn/presentations/widget/impl/app_title_text.dart';

import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/utils/extension/date_extension.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().fetchHistoryList();
    });
  }

  void _refreshListView() {
  
  }

  @override
  Widget build(BuildContext context) {
    bool isHistoryNotEmpty = false;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: const AppTitleText(
          text: 'History',
          color: AppColors.primary,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (isHistoryNotEmpty == true) {
                _deleteAllConfirmationDialog();
              } else {
                EasyLoading.showToast('History connection list is empty' );
              }
            },
            child: const Icon(Icons.delete, color: Colors.white,),
          )
            
          
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state.histories.isNotEmpty) {
              isHistoryNotEmpty = true;
            } else {
              isHistoryNotEmpty = false;
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: state.histories.isEmpty,
                  child: const Column(
                    children: [
                      
                      SizedBox(height: 150),
                      SizedBox(height: 16),
                      AppBodyText(
                        text: 'Your history connect server is empty!',
                        size: 20,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                      const SizedBox(
                          width: 80,
                          height: 80,
                        ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                Visibility(
                  visible: state.histories.isNotEmpty,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      final history = state.histories[index];
                      return _buildHistoryItem(history);
                    },
                    itemCount: state.histories.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteAllConfirmationDialog() async {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
             'Clear All history',
          ),
          content: const Text(
                'Are you sure you want to clear All the server history information?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
              ),
            ),
            TextButton(
              onPressed: ()  {
                  getIt<AppDatabase>().deleteAllHistories((){
                    _refreshListView();
                  if (!context.mounted) return;
                  // Navigator.of(context).popUntil((route) => route.isFirst);
                  EasyLoading.showToast('All History connection is deleted');
                  // Future.delayed(Duration(seconds: 2), () {
                  //   setState(() {
                  //     //return _refreshListView();
                  //   });
                  // });
                  context.read<AppCubit>().fetchHistoryList();
                  Navigator.pop(context);
                });
              },
              child: const Text('Delete')
            ),
          ],
        );
      },
    );
  }

  Widget _buildHistoryItem(HistoryModel history) {
    final server = history.vpnServerModel;
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: server.flag,
                width: 35,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBodyText(
                color: AppColors.primary,
                text: server.country ?? '',
              ),
            ],
          ),
          const Spacer(),
          AppBodyText(
            text: history.createAt.toStringFormatted(),
            size: 12,
            color: AppColors.textPrimary,
          )
        ],
      ),
    );
  }
}
