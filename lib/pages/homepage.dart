import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trafik/products/modals/add_warning_modal.dart';
import 'package:trafik/products/paddings/padding.dart';
import 'package:trafik/products/variables/user_info.dart';

import '../core/models/warning_model.dart';
import '../core/services/api_service.dart';
import '../products/widgets/warning_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool? _isLoading = false;
List<WarningModel> _warnings = [];
final String? location = UserInfo.user?[0].sehiradi;
int seciliSayfa = 0;

class _HomePageState extends State<HomePage> {
  Future<void> getWarnings() async {
    _isLoading = true;
    final data = {
      "operation_type": "select",
      "service_type": "warnings",
      "sehiradi": location
    };
    final response = await Dio().post(ApiService.api, data: data);
    if (response.statusCode == HttpStatus.OK) {
      final _datas = jsonDecode(response.data);
      print(_datas);
      if (_datas is List) {
        if (_datas[0] != "İlan bulunamadı.") {
          print(_datas);
          setState(() {
            _warnings = [];
            _warnings = _datas.map((e) => WarningModel.fromJson(e)).toList();
            _isLoading = false;
          });
        } else {
          setState(() {
            _warnings = [];
            _isLoading = false;
          });
        }
      }
    }
  }

  int currentIndex = 0;
  void initState() {
    super.initState();
    print(location);
    getWarnings();
  }

  void openAddWarninModal() {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AddWarningModal(),
            ],
          );
        });
  }

  // void openChangeLocationModal() {
  //   showModalBottomSheet<void>(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children:const [
  //             ChangeLocationModal(),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await getWarnings();
          },
          child: Padding(
            padding: Paddings.globalPadding,
            child: Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                floatingActionButton: FloatingActionButton(
                  child:const Icon(Icons.add),
                  onPressed: () {
                    openAddWarninModal();
                  },
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                body: _isLoading == true
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : SingleChildScrollView(
                        child: Column(children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              Text(
                                location.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                         
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: _warnings.length == 0
                                ? Text('Henüz bir uyarı bulunmamaktadır')
                                : Padding(
                                  padding: const EdgeInsets.only(bottom:128.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: _warnings.length,
                                      itemBuilder: (BuildContext ctxt, int index) {
                                        return WarningCard(
                                          title: _warnings[index].title.toString(),
                                          description:
                                              _warnings[index].description.toString(),
                                          createdAt: _warnings[index]
                                              .createdAt
                                              .toString()
                                              .substring(11, 16),
                                          iconUrl:
                                              _warnings[index].iconUrl.toString(),
                                        );
                                      },
                                    ),
                                ),
                          ),
                        ]),
                      )),
          ),
        ),
      ),
    );
  }
}
