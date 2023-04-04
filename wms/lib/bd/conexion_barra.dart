class produc {
  final int id;
  final String descripcion;
  final String precio;
  final int codigo_barras;
  final String error;

  produc({
    required this.id,
    required this.descripcion,
    required this.precio,
    required this.codigo_barras,
    required this.error,
  });

  factory produc.fromJson(Map<String, dynamic> json) {
    return produc(
      id: json["id"],
      descripcion: json["descripcion"],
      precio: json["precio"],
      codigo_barras: json["codigo_barras"],
      error: json["error"],
    );
  }
}

class Error {
  final String error;

  Error({
    required this.error,
  });

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      error: json["error"],
    );
  }
}
