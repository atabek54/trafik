import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/addwarning_widget.dart';

class AddWarningModal extends StatefulWidget {
  const AddWarningModal({super.key});

  @override
  State<AddWarningModal> createState() => _AddWarningModalState();
}

late String _description;

class _AddWarningModalState extends State<AddWarningModal> {
  @override
  Widget build(BuildContext context) {
    return AddWarningModalWidget();
  }
}
