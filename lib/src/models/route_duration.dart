class RouteDuration {
  const RouteDuration({
    required this.text,
    required this.seconds,
  });

  factory RouteDuration.fromJson(Map<String, dynamic> json) => RouteDuration(
        text: json['text'],
        seconds: json['value'],
      );

  final int seconds;
  final String text;

  Duration get value => Duration(seconds: seconds);

  RouteDuration copyWith({
    String? text,
    int? seconds,
  }) =>
      RouteDuration(
        text: text ?? this.text,
        seconds: seconds ?? this.seconds,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': seconds,
      };
}
