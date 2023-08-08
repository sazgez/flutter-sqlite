import 'package:flutter/material.dart';

PopupMenuItem infoButton({required BuildContext context}) {
  return PopupMenuItem(
    onTap: () => showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Essential Information'),
        content: Text('data'),
      ),
    ),
    child: const Icon(
      Icons.info_outlined,
      color: Colors.white,
    ),
  );
}