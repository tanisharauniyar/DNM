import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utills/themes.dart';

class CustomTable extends StatefulWidget {
  final List<GridTableSummaryRow> tableSummaryRows;
  final DataGridSource source;
  final List<GridColumn> columns;
  final List<StackedHeaderRow> stackedHeaders;
  final Widget? footer;
  final ColumnWidthMode columnWidthMode;
  final bool showIndicator;
  final ScrollPhysics verticalScrollPhysics;
  final ScrollController? parentController;

  const CustomTable({
    super.key,
    required this.tableSummaryRows,
    required this.source,
    required this.columns,
    this.footer,
    this.verticalScrollPhysics = const ClampingScrollPhysics(),
    this.showIndicator = true,
    required this.columnWidthMode,
    this.stackedHeaders = const [],
    this.parentController,
    //required header,
  });

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  ScrollController horizontalController = ScrollController();
  bool showIndicator = false;

  bool showLeftIndicator = false;
  bool showRightIndicator = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (horizontalController.position.maxScrollExtent > 0) {
        showIndicator = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.axis == Axis.horizontal) {
                  if (!notification.metrics.atEdge) {
                    showRightIndicator = true;
                    showLeftIndicator = true;
                    setState(() {});
                    return true;
                  }
                  if (notification.metrics.atEdge) {
                    if (notification.metrics.pixels == 0) {
                      showRightIndicator = true;
                      showLeftIndicator = false;
                      setState(() {});

                      return true;
                    } else {
                      showRightIndicator = false;
                      showLeftIndicator = true;
                      setState(() {});

                      return true;
                    }
                  }

                  return true;
                }
                return true;
              },
              child: NotificationListener<OverscrollNotification>(
                onNotification: (notification) {
                  if (widget.parentController?.hasClients ?? false) {
                    if (notification.metrics.axisDirection ==
                        AxisDirection.down) {
                      if (notification.overscroll < 0 &&
                          widget.parentController!.offset +
                                  notification.overscroll <=
                              0) {
                        if (widget.parentController?.offset != 0) {
                          widget.parentController?.animateTo(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                        return true;
                      }
                      if (widget.parentController!.offset +
                                  notification.overscroll >=
                              widget
                                  .parentController!.position.maxScrollExtent ??
                          false) {
                        if (widget.parentController?.offset !=
                            widget.parentController?.position.maxScrollExtent) {
                          widget.parentController?.animateTo(
                              widget.parentController!.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }

                        return true;
                      }
                      widget.parentController!.jumpTo(
                        widget.parentController!.offset +
                            notification.overscroll,
                      );
                      return true;
                    }
                    return false;
                  }
                  return true;
                },
                child: Container(
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                        headerColor: Themes.defaultGreenColor,
                        gridLineColor: Colors.black.withOpacity(0.5),
                        // groupExpanderIcon: Icon(Icons.add),
                        ///for the icon column colour
                        indentColumnColor:
                            Themes.defaultGreenColor.withOpacity(0.4)),
                    child: SfDataGrid(
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      horizontalScrollController: horizontalController,
                      gridLinesVisibility: GridLinesVisibility.vertical,
                      columnWidthMode: widget.columnWidthMode,
                      tableSummaryRows: widget.tableSummaryRows,
                      verticalScrollPhysics: widget.verticalScrollPhysics,
                      rowHeight: 120.r,
                      headerRowHeight: 150.r,
                      source: widget.source,
                      columns: widget.columns,
                      footer: widget.footer,
                      stackedHeaderRows: widget.stackedHeaders,
                      allowExpandCollapseGroup: true,
                      allowEditing: true,
                      groupCaptionTitleFormat:
                          '{ColumnName} : {Key} - {ItemsCount} Item(s)',
                    ),
                  ),
                ),
              ),
            ),
            if (showIndicator)
              Center(
                child: SizedBox(
                  height: 150.r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (showLeftIndicator)
                        SizedBox(
                          height: 150.r,
                          width: 50.r,
                          child: Image.asset(
                            "assets/images/back.png",
                            color: Colors.black.withOpacity(0.2),
                            fit: BoxFit.fill,
                          ),
                        ),
                      const Spacer(),
                      if (showRightIndicator)
                        SizedBox(
                          height: 150.r,
                          width: 50.r,
                          child: Image.asset(
                            "assets/images/forward.png",
                            color: Colors.black.withOpacity(0.2),
                            fit: BoxFit.fill,
                          ),
                        ),
                    ],
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}