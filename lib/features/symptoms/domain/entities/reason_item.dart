import 'package:equatable/equatable.dart';

class ReasonItem extends Equatable {
  const ReasonItem({
    required this.id,
    required this.name,
    required this.isOther,
  });

  final int id;
  final String name;
  final bool isOther;

  @override
  List<Object> get props => [id, name, isOther];
}
