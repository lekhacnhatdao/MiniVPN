import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/widget/impl/loading_buttons.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/icondata.dart';
import 'package:openvpn/resources/theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedTestPage extends StatefulWidget {
  const SpeedTestPage({super.key});

  @override
  State<SpeedTestPage> createState() => _SpeedTestPageState();
}

class _SpeedTestPageState extends State<SpeedTestPage> {
  final internetSpeedTest = FlutterInternetSpeedTest()..enableLog();

  bool _testInProgress = false;
  double _downloadRate = 0;
  double _uploadRate = 0;
  String _downloadProgress = '0';
  String _uploadProgress = '0';
  int _downloadCompletionTime = 0;
  int _uploadCompletionTime = 0;
  bool _isServerSelectionInProgress = false;

  String? _ip;
  String? _asn;
  String? _isp;

  String _unitText = 'Mbps';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              'Speed test',
              style: CustomTheme.textTheme.labelLarge?.copyWith(),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // const Text(
                    //   'Download Speed',
                    //   style: TextStyle(
                    //     fontSize: 16.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // Text('Progress: $_downloadProgress%'),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: SfRadialGauge(
                            axes: [
                              RadialAxis(
                                radiusFactor: 0.85,
                                minorTicksPerInterval: 1,
                                tickOffset: 3,
                                useRangeColorForAxis: true,
                                minimum: 0,
                                maximum: 60,
                                interval: 8,
                                axisLabelStyle: GaugeTextStyle(
                                  color: Colors.white,
                                ),
                                axisLineStyle: AxisLineStyle(
                                  color: Colors.white,
                                ),
                                ranges: [
                                  GaugeRange(
                                    labelStyle:
                                        GaugeTextStyle(color: Colors.white),
                                    startValue: 0,
                                    endValue:
                                       _downloadRate
                                            ,
                                    color: Color(0xff00D589),
                                  )
                                ],
                                pointers: [
                                  NeedlePointer(
                                    value:_downloadRate
                                        ,
                                    enableAnimation: true,
                                    needleColor: Colors.orange,
                                    tailStyle: const TailStyle(
                                        color: Colors.red,
                                        borderWidth: 0.1,
                                        borderColor: Colors.blue),
                                    knobStyle: KnobStyle(
                                        color: AppColors.icon,
                                        borderColor: Colors.red),
                                  ),
                                ],
                                annotations: [
                                  GaugeAnnotation(
                                    widget: Container(
                                      child: Text('Download' +
                                          ' ${_downloadRate.toStringAsFixed(2)}' +
                                          'MB/S',style: CustomTheme.textTheme.labelLarge?.copyWith()),
                                    ),
                                    angle: 90,
                                    positionFactor: 1,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: SfRadialGauge(
                            axes: [
                              RadialAxis(
                                radiusFactor: 0.85,
                                minorTicksPerInterval: 1,
                                tickOffset: 3,
                                useRangeColorForAxis: true,
                                minimum: 0,
                                maximum: 60,
                                interval: 8,
                                axisLabelStyle: GaugeTextStyle(
                                  color: Colors.white,
                                ),
                                axisLineStyle: AxisLineStyle(
                                  color: Colors.white,
                                ),
                                ranges: [
                                  GaugeRange(
                                    labelStyle:
                                        GaugeTextStyle(color: Colors.white),
                                    startValue: 0,
                                    endValue:
                                      _uploadRate
                                             ,
                                    color: Color(0xff00D589),
                                  )
                                ],
                                pointers: [
                                  NeedlePointer(
                                    value: _uploadRate
                                       ,
                                    enableAnimation: true,
                                    needleColor: Colors.orange,
                                    tailStyle: const TailStyle(
                                        color: Colors.red,
                                        borderWidth: 0.1,
                                        borderColor: Colors.blue),
                                    knobStyle: KnobStyle(
                                        color: AppColors.icon,
                                        borderColor: Colors.red),
                                  ),
                                ],
                                annotations: [
                                  GaugeAnnotation(
                                    widget: Container(
                                      child: Text('Upload' +
                                          ' ${_uploadRate.toStringAsFixed(2)}' +
                                          'MB/S', style: CustomTheme.textTheme.labelLarge?.copyWith(),),
                                    ),
                                    angle: 90,
                                    positionFactor: 1,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // if (_downloadCompletionTime > 0)
                    //   Text(
                    //       'Time taken: ${(_downloadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                  ],
                ),

                // if (_uploadCompletionTime > 0)
                //   Text(
                //       'Time taken: ${(_uploadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                // const SizedBox(
                //   height: 32.0,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 16.0),
                //   child: Text(_isServerSelectionInProgress
                //       ? 'Selecting Server...'
                //       : 'IP: ${_ip ?? '--'} | ASP: ${_asn ?? '--'} | ISP: ${_isp ?? '--'}'),
                // ),
               
                  LoadingButtons(
                    size: 70,
                    icondata: Appicon.wifi,
                    isLoading: _testInProgress,
                    icon: Icon(Appicon.menu),
                    text: 'connecting',
                    onPressed: 
                      () async {
                  
                        if (state.titleStatus != 'Connected' || state.titleStatus =='Not connected') {
                          reset();
                          await internetSpeedTest.startTesting(onStarted: () {
                            setState(() => _testInProgress = true);
                          }, onCompleted:
                              (TestResult download, TestResult upload) {
                            if (kDebugMode) {
                              print(
                                  'the transfer rate ${download.transferRate}, ${upload.transferRate}');
                            }
                            setState(() {
                              _downloadRate = download.transferRate;
                              _unitText = download.unit == SpeedUnit.kbps
                                  ? 'Kbps'
                                  : 'Mbps';
                              _downloadProgress = '100';
                              _downloadCompletionTime =
                                  download.durationInMillis;
                            });
                            setState(() {
                              _uploadRate = upload.transferRate;
                              _unitText = upload.unit == SpeedUnit.kbps
                                  ? 'Kbps'
                                  : 'Mbps';
                              _uploadProgress = '100';
                              _uploadCompletionTime = upload.durationInMillis;
                              _testInProgress = false;
                            });
                          }, onProgress: (double percent, TestResult data) {
                            if (kDebugMode) {
                              print(
                                  'the transfer rate $data.transferRate, the percent $percent');
                            }
                            setState(() {
                              _unitText =
                                  data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                              if (data.type == TestType.download) {
                                _downloadRate = data.transferRate;
                                _downloadProgress = percent.toStringAsFixed(2);
                              } else {
                                _uploadRate = data.transferRate;
                                _uploadProgress = percent.toStringAsFixed(2);
                              }
                            });
                          }, onError:
                              (String errorMessage, String speedTestError) {
                            if (kDebugMode) {
                              print(
                                  'the errorMessage $errorMessage, the speedTestError $speedTestError');
                            }
                            reset();
                          }, onDefaultServerSelectionInProgress: () {
                            setState(() {
                              _isServerSelectionInProgress = true;
                            });
                          }, onDefaultServerSelectionDone: (Client? client) {
                            setState(() {
                              _isServerSelectionInProgress = false;
                              _ip = client?.ip;
                              _asn = client?.asn;
                              _isp = client?.isp;
                            });
                          }, onDownloadComplete: (TestResult data) {
                            setState(() {
                              _downloadRate = data.transferRate;
                              _unitText =
                                  data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                              _downloadCompletionTime = data.durationInMillis;
                            });
                          }, onUploadComplete: (TestResult data) {
                            setState(() {
                              _uploadRate = data.transferRate;
                              _unitText =
                                  data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                              _uploadCompletionTime = data.durationInMillis;
                            });
                          }, onCancel: () {
                            reset();
                          });
                        };
                      
                    },
                    changeUI: true,
                  ),
                
                 _testInProgress? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      onPressed: () => internetSpeedTest.cancelTest(),
                      icon: const Icon(Icons.cancel_rounded),
                      label: const Text('Cancel'),
                    ),
                  ): SizedBox(),
                
              ],
            ),
          ),
        );
      },
    );
  }

  void reset() {
    setState(() {
      {
        _testInProgress = false;
        _downloadRate = 0;
        _uploadRate = 0;
        _downloadProgress = '0';
        _uploadProgress = '0';
        _unitText = 'Mbps';
        _downloadCompletionTime = 0;
        _uploadCompletionTime = 0;

        _ip = null;
        _asn = null;
        _isp = null;
      }
    });
  }
}
