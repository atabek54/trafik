import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:trafik/pages/homepage.dart';
import 'package:trafik/products/paddings/padding.dart';
import 'package:trafik/products/texts/text.dart';
import 'package:trafik/products/variables/user_info.dart';
import 'package:trafik/products/widgets/global_button.dart';

import '../../core/services/api_service.dart';

class AddWarningModalWidget extends StatefulWidget {
  const AddWarningModalWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddWarningModalWidget> createState() => _AddWarningModalWidgetState();
}

bool? _isLoading;
String? _description;
Future<void> addWarning() async {
  _isLoading = true;
  EasyLoading.show(status: 'loading...');
print(UserInfo.user?[0].uuid);
  final data = {
    "operation_type": "insert",
    "service_type": "add_warning",
    "description": _description.toString(),
    "userId": UserInfo.user?[0].uuid.toString(),
    "typeId": _currentSelection
  };
  final response = await Dio().post(ApiService.api, data: data);
  if (response.statusCode == HttpStatus.OK) {
    // final _datas = jsonDecode(response.data);
    if (response.data is Null) {
      // İlan eklenemedi
      EasyLoading.showError('İlan Eklenmedi.');
    } else {
      EasyLoading.showSuccess('İlan Başarıyla Eklendi.');
    }

    // if (_datas is List) {
    //   if (_datas[0] != "İlan eklenemedi") {}
    // }
  }
}

Map<int, Widget> _children =  {
  0: Text('Radar',style: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.w700),),
  1: Text('Çevirme',style: GoogleFonts.quicksand(fontSize:18,fontWeight: FontWeight.w700),),
  2: Text('Kaza',style: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.w700),),
};
int _currentSelection = 0;
final myController = TextEditingController();

class _AddWarningModalWidgetState extends State<AddWarningModalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: Paddings.globalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Uyarı Ekle', style: GoogleFonts.quicksand(fontSize: 30,),),
_empty(80),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Trafikte karşılaştığın olayları paylaşarak diğer sürücüleri önceden bilgilendir',style: 
              GoogleFonts.quicksand(fontSize: 26,),),
            ),
            _empty(50),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MaterialSegmentedControl(
                
                children: _children,
                selectionIndex: _currentSelection,
                borderColor: Colors.grey,
                selectedColor: Color.fromARGB(255, 212, 90, 15),
                unselectedColor: Colors.white,
                borderRadius: 32.0,
                onSegmentChosen: (index) {
                  setState(() {
                    _currentSelection = index;
                  });
                },
              ),
            ),
            _empty(50),
            Padding(
              padding: Paddings.globalPadding,
              child: TextFormField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: Texts.addModalFormText,
                  labelStyle: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
            ),
            _empty(100),
            GlobalButtonWidget(
                loginButtonOnPressed: _description != null
                    ? () async {
                        addWarning();
                        myController.clear();
                        print(_description);
                        await Future.delayed(
                            const Duration(milliseconds: 1500), () => {
                              
                            });
                        Navigator.pop(context);
                      }
                    : () {},
                text: Texts.addButtonText)
          ],
        ),
      ),
    );
  }

  SizedBox _empty(double value) => SizedBox(height: value);
}
