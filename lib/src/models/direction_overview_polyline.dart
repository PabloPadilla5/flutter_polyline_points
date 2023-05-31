class DirectionOverviewPolyline {
  const DirectionOverviewPolyline({
    required this.points,
  });

  factory DirectionOverviewPolyline.fromJson(Map<String, dynamic> json) =>
      DirectionOverviewPolyline(
        points: json['points'],
      );

  final String points;

  DirectionOverviewPolyline copyWith({
    String? points,
  }) =>
      DirectionOverviewPolyline(
        points: points ?? this.points,
      );

  Map<String, dynamic> toJson() => {
        'points': points,
      };
}
