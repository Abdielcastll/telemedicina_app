import 'package:telemedicina_app/features/symptoms/domain/entities/reason_item.dart';

class ReasonItemModel extends ReasonItem {
  const ReasonItemModel({
    required super.id,
    required super.name,
    required super.isOther,
  });

  factory ReasonItemModel.fromJson(Map<String, dynamic> json) {
    return ReasonItemModel(
      id: (json['ReasonId'] as num?)?.toInt() ?? 0,
      name: (json['ReasonName'] ?? '').toString(),
      isOther: json['IsOther'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ReasonId': id, 'ReasonName': name, 'IsOther': isOther};
  }
}
