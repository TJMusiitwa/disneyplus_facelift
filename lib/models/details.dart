import 'dart:convert';

import 'package:disneyplus_facelift/models/movies_result.dart';

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  Details({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieResult> results;
  final int totalPages;
  final int totalResults;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        page: json["page"],
        results: List<MovieResult>.from(
            json["results"].map((x) => MovieResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
