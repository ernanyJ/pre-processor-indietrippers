import 'dart:convert';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

import 'Roteiro.dart';

void main() async {
  final apiKey = Platform.environment['GEMINI_API_KEY'];
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey!);

  String prompt = '''

Baseado no {PERFIL} de viajante, retorne em formato JSON um roteiro de viagem para a cidade de {CIDADE}

- {DESTINO}, com um valor em reais aproximado de gasto por dia. O roteiro em json deverá ter o seguinte formato: {FORMATO}

NÃO responda nenhum caractere além do json corretamente formatado.

{DESTINO}
Peru

{CIDADE}
Cusco

{PERFIL}
tipoViagem: [aventureiro, explorador, casal]
duracao: 4 dias
orcamento: 3.000
preferenciaHospedagem: [barato]
preferenciaComida: [comida regional, comida italiana]
preferenciaAtracoes: [bares, restaurantes, cafe, teatro]

{FORMATO}
Um JSON que contenha os parâmetros: 
- um array 'dias', em que cada item da array contenha os parametros com o numero equivalente do dia (por exemplo, dia 1, dia 2, dia 3.....), 
- o nome do lugar a ser visitado (pode ser uma atração, um restaurante, etc), o nome deste parâmetro é 'nomeLugar'
- o valor total gasto do dia, o nome deste parâmetro é 'valorTotal'.

''';

  final content = [Content.text(prompt)];

  int erros = 0;
  int acertos = 0;
  while (true) {
    try {
      final response = await model.generateContent(content);
      String str = response.text!;

      // se a string começar com o caractere (`), ela vai ser formatada para retirar todos os caracteres
      // indesejados, que já são previamente conhecidos.

      if (str[0] == '`') {
        str = str.substring(str.indexOf('n') + 1, str.lastIndexOf('`') - 2);
      }

      Roteiro rot = Roteiro.fromJson(jsonDecode(str));

      for (var element in rot.dias!) {
        print("dia: ${element.dia}");
        print("nome: ${element.nomeLugar}");
        print("valor: ${element.valorTotal}");
      }
      acertos++;
      print('erros: $erros | acertos: $acertos');
    } catch (e, stacktrace) {
      erros++;
      print(stacktrace);  
    }
  }
}
