import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PDFViewerScreen extends StatefulWidget {
  const PDFViewerScreen({super.key});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  bool isLoading = true;
  PDFDocument? document = null;

  loadDocument() async {
    document = await PDFDocument.fromURL(
        'https://www.ecma-international.org/wp-content/uploads/ECMA-262_12th_edition_june_2021.pdf');
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading || document == null
        ? Center(child: CircularProgressIndicator())
        : PDFViewer(
            document: document!,
            lazyLoad: false,
            zoomSteps: 1,
            numberPickerConfirmWidget: const Text(
              "Confirm",
            ));
  }
}
