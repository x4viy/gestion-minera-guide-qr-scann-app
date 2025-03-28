import 'package:flutter/material.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_guide.dart';

class SelectGuidePage extends StatelessWidget {
  static route({required LoadingGuide loadingGuide}) => MaterialPageRoute(
        builder: (context) => SelectGuidePage(loadingGuide: loadingGuide),
      );
  const SelectGuidePage({super.key, required this.loadingGuide});
  final LoadingGuide loadingGuide;

  @override
  Widget build(BuildContext context) {
    const double detailHeight = 50;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        Navigator.pop(context, true);
      },
      // child: Scaffold(
      //   appBar: AppBar(title: const Text('Select Guide')),
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text('Select Guide Page code: $code'),
      //         ElevatedButton(
      //           onPressed: () {
      //             // Return true when popping the page
      //             // for the scanner to start again.
      //             Navigator.pop(context, true);
      //           },
      //           child: const Text('Cerrar'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            // First SliverList: a list of cards (one per row)
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: headerMaterialDetailStack(context, loadingGuide,
                      detailHeight: detailHeight),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: vehicleDetailCards(),
                ),
                personsDetails(),
              ]),
            ),
            // Second SliverList: a list with a single card per row
          ],
        ),
      ),
    );
  }
}

Widget headerMaterialDetailStack(
    BuildContext context, LoadingGuide loadingGuide,
    {required double detailHeight}) {
  const double detailPadding = 8;
  const double fromTop = 100;
  const double tableHeaderPaddingTop = 20;
  const double tableHeaderPaddingButtom = 10;
  const double titleHeaderMateialFont = 20;
  const double backgroundHeight = 200;
  const double detailTotalHeight = 50;
  const double titleTotalDetailsize = 20;

  double totalHeight =
      (loadingGuide.guideDetails.length) * (detailHeight + detailPadding) +
          tableHeaderPaddingTop +
          tableHeaderPaddingButtom +
          titleHeaderMateialFont +
          (detailTotalHeight + detailPadding) +
          20;

  double totalQuantityMaterial = loadingGuide.guideDetails
      .map((detail) => detail.quantity)
      .reduce((a, b) => a + b);
  // stack used to show the header and the material detail card
  return SizedBox(
    // this is the height of the total stack
    // that contains the header and the material detail card
    height: backgroundHeight + (totalHeight - fromTop),
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Background card
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: backgroundHeight,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Material detail card
        Positioned(
          top: fromTop,
          child: SizedBox(
            height: totalHeight,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  materialDetailHeaderTable(
                      tableHeaderPaddingButtom: tableHeaderPaddingButtom,
                      tableHeaderPaddingTop: tableHeaderPaddingTop,
                      titleHeaderMateialFont: titleHeaderMateialFont),
                  // For each material detail, create a row
                  ...loadingGuide.guideDetails.map((detail) {
                    return _materialDetailRow(context,
                        materialName: detail.material?.name ?? 'Sin nombre',
                        quantity: detail.quantity.toString(),
                        height: detailHeight,
                        padding: detailPadding);
                  }),
                  materialDetailTotal(
                    context,
                    total: totalQuantityMaterial.toStringAsFixed(2),
                    height: detailTotalHeight,
                    padding: detailPadding,
                    fontSize: titleTotalDetailsize,
                  ),
                  // Add the last row with the total
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Padding materialDetailHeaderTable(
    {required double tableHeaderPaddingButtom,
    required double tableHeaderPaddingTop,
    required double titleHeaderMateialFont}) {
  return Padding(
    padding: EdgeInsets.only(
        bottom: tableHeaderPaddingButtom, top: tableHeaderPaddingTop),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Material',
          style: TextStyle(fontSize: titleHeaderMateialFont),
        ),
        Text('m\u00B3'),
      ],
    ),
  );
}

Widget _materialDetailRow(BuildContext context,
    {required String materialName,
    required String quantity,
    required double height,
    required double padding}) {
  return Stack(alignment: Alignment.center, children: [
    Padding(
      padding: EdgeInsets.only(top: padding / 2, bottom: padding / 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: height,
          width: MediaQuery.of(context).size.width * 0.75,
          color: Colors.grey[850],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 20)),
                    controller: TextEditingController(text: materialName),
                    enableInteractiveSelection: false,
                    textAlign: TextAlign.left,
                    readOnly: true,
                    scrollPhysics: AlwaysScrollableScrollPhysics(),
                    scrollController: ScrollController(),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(1),
                  ),
                  textAlign: TextAlign.left,
                  initialValue: quantity,
                  readOnly: true,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ]);
}

Widget materialDetailTotal(BuildContext context,
    {required String total,
    required double height,
    required double padding,
    required double fontSize}) {
  return Stack(alignment: Alignment.center, children: [
    Padding(
      padding: EdgeInsets.only(top: padding / 2, bottom: padding / 2),
      child: SizedBox(
        height: height,
        width: MediaQuery.of(context).size.width * 0.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                'Total',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  total,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ]);
}

Widget vehicleDetailCards() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.directions_car),
              Text('Vehicle'),
              Text('Vehicle Value'),
            ],
          ),
          Column(
            children: [
              Icon(Icons.person),
              Text('Driver'),
              Text('Driver Value'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget personsDetails() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.person),
              Text('Person 1'),
              Text('Person 1 Value'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person),
              Text('Person 2'),
              Text('Person 2 Value'),
            ],
          ),
        ],
      ),
    ),
  );
}
