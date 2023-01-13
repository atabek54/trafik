import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trafik/products/texts/text.dart';

class WarningCard extends StatefulWidget {
  const WarningCard({
    Key? key,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.iconUrl,
  }) : super(key: key);
  final String title;
  final String description;
  final String createdAt;
  final String iconUrl;

  @override
  State<WarningCard> createState() => _WarningCardState();
}

class _WarningCardState extends State<WarningCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 21.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: CustomColor.warningCardColor,
              borderRadius: BorderRadius.circular(22)),
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 56,
                  width: 56,
                  child: Image.network(widget.iconUrl),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(widget.title,
                            style: TextsStyles.warningCardHeader),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("(${widget.createdAt})"),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: 250,
                        child: Text(widget.description,
                            style: TextsStyles.warningCardDesc))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
