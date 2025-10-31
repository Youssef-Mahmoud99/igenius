import 'package:flutter/material.dart';

class InfoDataCard extends StatelessWidget {
const InfoDataCard({ Key? key, required this.child }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.4),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Colors.white,
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}