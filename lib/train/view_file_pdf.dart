import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:test/train/training_book_data.dart';

class ViewPDF extends StatefulWidget {
  final Trainingbookdata Showpdf;
  const ViewPDF({Key? key, required this.Showpdf}) : super(key: key);

  @override
  State<ViewPDF> createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late Trainingbookdata PDFfileview;
  @override
  void initState() {
    super.initState();
    PDFfileview = widget.Showpdf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('${PDFfileview.message.name}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        '${PDFfileview.message.file}',
        key: _pdfViewerKey,
      ),
    );
  }
}