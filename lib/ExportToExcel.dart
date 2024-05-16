import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class ExportToExcelData extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;

  const ExportToExcelData({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
  });

  @override
  State<ExportToExcelData> createState() => _ExportToExcelDataState();
}

class _ExportToExcelDataState extends State<ExportToExcelData> {
  void exportToExcel() {
    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        'Title';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        'Original title';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        'Votes';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        'Rating';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
        'value';

    for (var movieIndex = 0; movieIndex < widget.movies.length; movieIndex++) {
      final movie = widget.movies[movieIndex];

      sheet
          .cell(CellIndex.indexByColumnRow(
              columnIndex: 0, rowIndex: movieIndex + 1))
          .value = movie.title;
      sheet
          .cell(CellIndex.indexByColumnRow(
              columnIndex: 1, rowIndex: movieIndex + 1))
          .value = movie.originalTitle;
      sheet
          .cell(CellIndex.indexByColumnRow(
              columnIndex: 2, rowIndex: movieIndex + 1))
          .value = movie.voteAverage.toString();
      sheet
          .cell(CellIndex.indexByColumnRow(
              columnIndex: 3, rowIndex: movieIndex + 1))
          .value = movie.popularity.toString();
    }

    excel.save(fileName: "MovieData.xlsx");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: exportToExcel,
        child: Text('Export to Excel'),
      ),
    );
  }
}
