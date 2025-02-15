class Datummove {
  int? id;
  String? date;
  String? type;
  String? notes;
  String? qty;
  String? priceUnit;
  String? status;
  int? clientId;
  int? electronicSaveId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datummove({
    this.id,
    this.date,
    this.type,
    this.notes,
    this.qty,
    this.priceUnit,
    this.status,
    this.clientId,
    this.electronicSaveId,
    this.createdAt,
    this.updatedAt,
  });

  factory Datummove.fromJson(Map<String, dynamic> json) => Datummove(
        id: json['id'] as int?,
        date: json['date'] as String?,
        type: json['type'] as String?,
        notes: json['notes'] as String?,
        qty: json['qty'] as String?,
        priceUnit: json['price_unit'] as String?,
        status: json['status'] as String?,
        clientId: json['client_id'] as int?,
        electronicSaveId: json['electronic_save_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'type': type,
        'notes': notes,
        'qty': qty,
        'price_unit': priceUnit,
        'status': status,
        'client_id': clientId,
        'electronic_save_id': electronicSaveId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
