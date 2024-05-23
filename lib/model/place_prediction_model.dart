class PlacePredictionModel {
  final Map<String, dynamic> map;
  const PlacePredictionModel({this.map = const {}});

  String get description => map['description'] as String? ?? '';
  // List<dynamic> get _matchedSubstrings =>
  //     map['matched_substrings'] as List<dynamic>? ?? [];
  // List<LengthOffSetModel> get matchedSubstrings =>
  //     _matchedSubstrings.map((e) => LengthOffSetModel(map: e)).toList();
  String get placeId => map['place_id'] as String? ?? '';
  String get reference => map['reference'] as String? ?? '';
  List<String> get types => map['types'] as List<String>? ?? [];
}

// {
//                "description" : "Kuwait",
//                "matched_substrings" :
//                [
//                   {
//                      "length" : 1,
//                      "offset" : 0
//                   }
//                ],
//                "place_id" : "ChIJoVHqvj82xT8R0u3Yks1rcnQ",
//                "reference" : "ChIJoVHqvj82xT8R0u3Yks1rcnQ",
//                "structured_formatting" :
//                {
//                   "main_text" : "Kuwait",
//                   "main_text_matched_substrings" :
//                   [
//                      {
//                         "length" : 1,
//                         "offset" : 0
//                      }
//                   ]
//                },
//                "terms" :
//                [
//                   {
//                      "offset" : 0,
//                      "value" : "Kuwait"
//                   }
//                ],
//                "types" :
//                [
//                   "country",
//                   "geocode",
//                   "political"
//                ]
//             }

class LengthOffSetModel {
  final Map<String, dynamic> map;
  const LengthOffSetModel({this.map = const {}});

  String get length => map['length'] as String? ?? '';
  String get offset => map['offset'] as String? ?? '';
  String get value => map['value'] as String? ?? '';
}
