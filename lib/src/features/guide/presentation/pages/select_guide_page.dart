import 'package:flutter/material.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_guide.dart';
import 'package:loadin_guide_scann/src/core/theme/app_pallete.dart';
import 'package:loadin_guide_scann/src/features/guide/presentation/widgets/person_detail.dart';

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
                  child: vehicleDetailCards(context, loadingGuide),
                ),
                personsDetails(context, loadingGuide),
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
  const double tableHeaderPaddingTop = 25;
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
              alignment: AlignmentDirectional.topStart,
              height: backgroundHeight,
              color: AppPallete.blueInfo,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 55, left: MediaQuery.of(context).size.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'N#',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    Text(
                      loadingGuide.guideHeader.guideNumber ?? 'Sin numero',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none),
                    ),
                  ],
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
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'm\u00B3',
            style: TextStyle(fontSize: titleHeaderMateialFont),
          ),
        ),
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

Widget vehicleDetailCards(BuildContext context, LoadingGuide loadingGuide) {
  double mediaQueryHeight = MediaQuery.of(context).size.height;
  double mediaQueryWidth = MediaQuery.of(context).size.width;
  return Center(
    child: SizedBox(
      height: mediaQueryHeight * 0.17,
      width: mediaQueryWidth * 0.9, // Set the desired width
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQueryWidth * 0.08, top: mediaQueryHeight * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.local_shipping_rounded,
                    size: 30,
                  ),
                  Text('Placa'),
                  Text(
                    loadingGuide.guideHeader.vehicle?.card ?? 'ABC-123',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQueryWidth * 0.28, top: mediaQueryHeight * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.speed,
                    size: 30,
                  ),
                  Text('Metraje'),
                  Text(
                    loadingGuide.guideHeader.vehicle?.volume.toString() ?? '15',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget personsDetails(BuildContext context, LoadingGuide loadingGuide) {
  double mediaQueryWidth = MediaQuery.of(context).size.width;
  double personDetailWidht = mediaQueryWidth * 0.8;
  return Center(
    child: SizedBox(
      width: mediaQueryWidth * 0.9, // Set the desired width
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PersonDetail(
                  label: 'Titular minero',
                  icon: Icons.account_circle,
                  text: 'Juan juancito polo polencio de nuncajamas',
                  width: personDetailWidht),
              PersonDetail(
                  label: 'Titular del vehículo',
                  icon: Icons.supervisor_account,
                  text: 'Juan juancito polo polencio',
                  width: personDetailWidht),
              PersonDetail(
                  label: 'Conductor del vehículo',
                  icon: Icons.sports_motorsports_rounded,
                  text: 'Juan juancito polo polencio',
                  width: personDetailWidht),
            ],
          ),
        ),
      ),
    ),
  );
}
