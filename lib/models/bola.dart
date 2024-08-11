class Bola {
  late int numero;
  late String texto;

  Bola({ required this.numero, required  this.texto});

  Bola.fromJson(Map<String, dynamic> map)
      : numero = map['numero'],
        texto = map['texto'];

  Map<String, dynamic> toMap() {
    return {
      "numero": numero,
      "texto": texto,
    };
  }
}