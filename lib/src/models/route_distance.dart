class RouteDistance {
  const RouteDistance({
    required this.text,
    required this.meters,
  });

  factory RouteDistance.fromJson(Map<String, dynamic> json) => RouteDistance(
        text: json['text'],
        meters: json['value'],
      );

  final int meters;
  final String text;

  RouteDistance copyWith({
    String? text,
    int? meters,
  }) =>
      RouteDistance(
        text: text ?? this.text,
        meters: meters ?? this.meters,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': meters,
      };
}
