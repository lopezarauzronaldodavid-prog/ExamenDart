import 'dart:io';
import 'dart:math';

// Método Lineal
double lineal(double costo, double valorResidual, int vida) {
  return (costo - valorResidual) / vida;
}

// Método Regresivo 1 (Rs1) - porcentaje fijo
List<double> regresivo1(double costo, double tasa, int vida) {
  List<double> depreciaciones = [];
  double valor = costo;

  for (int i = 0; i < vida; i++) {
    double dep = valor * tasa;
    depreciaciones.add(dep);
    valor -= dep;
  }
  return depreciaciones;
}

// Saldo decreciente doble (DB2)
List<double> db2(double costo, int vida) {
  List<double> depreciaciones = [];
  double valor = costo;
  double tasa = (2 / vida);

  for (int i = 0; i < vida; i++) {
    double dep = valor * tasa;
    depreciaciones.add(dep);
    valor -= dep;
  }
  return depreciaciones;
}

// DB1/SL (comparación)
List<double> db1sl(double costo, double valorResidual, int vida) {
  List<double> depreciaciones = [];
  double valor = costo;

  for (int i = 1; i <= vida; i++) {
    double db = valor * (1 / vida);
    double sl = (valor - valorResidual) / (vida - i + 1);
    double dep = max(db, sl);

    depreciaciones.add(dep);
    valor -= dep;
  }
  return depreciaciones;
}

// DB2/SL
List<double> db2sl(double costo, double valorResidual, int vida) {
  List<double> depreciaciones = [];
  double valor = costo;

  for (int i = 1; i <= vida; i++) {
    double db = valor * (2 / vida);
    double sl = (valor - valorResidual) / (vida - i + 1);
    double dep = max(db, sl);

    depreciaciones.add(dep);
    valor -= dep;
  }
  return depreciaciones;
}

// Convenio de medio año
List<double> medioAnio(double costo, double valorResidual, int vida) {
  double depAnual = (costo - valorResidual) / vida;
  List<double> depreciaciones = [];

  depreciaciones.add(depAnual / 2); // primer año

  for (int i = 1; i < vida; i++) {
    depreciaciones.add(depAnual);
  }

  depreciaciones.add(depAnual / 2); // último año

  return depreciaciones;
}

// Amortización definida por el usuario
List<double> personalizada(List<double> valores) {
  return valores;
}

// Guía de usuario
void guia() {
  print("""
=== GUÍA DE USO ===
1. Selecciona un método
2. Ingresa los datos solicitados:
   - Costo del activo
   - Valor residual
   - Vida útil
3. El sistema mostrará la depreciación por año
""");
}

// Menú
void menu() {
  while (true) {
    print("""
==== MENÚ DE DEPRECIACIÓN ====
1. Lineal
2. Regresivo 1 (Rs1)
3. Saldo decreciente doble (DB2)
4. DB1/SL
5. DB2/SL
6. Convenio medio año
7. Guía de usuario
8. Amortización personalizada
9. Salir
Seleccione una opción:
""");

    int opcion = int.parse(stdin.readLineSync()!);

    if (opcion == 9) break;

    switch (opcion) {
      case 1:
        print("Costo:");
        double c = double.parse(stdin.readLineSync()!);
        print("Valor residual:");
        double r = double.parse(stdin.readLineSync()!);
        print("Vida útil:");
        int v = int.parse(stdin.readLineSync()!);

        print("Depreciación anual: ${lineal(c, r, v)}");
        break;

      case 2:
        print("Costo:");
        double c = double.parse(stdin.readLineSync()!);
        print("Tasa (ej: 0.2):");
        double t = double.parse(stdin.readLineSync()!);
        print("Vida útil:");
        int v = int.parse(stdin.readLineSync()!);

        print(regresivo1(c, t, v));
        break;

      case 3:
        print("Costo:");
        double c = double.parse(stdin.readLineSync()!);
        print("Vida útil:");
        int v = int.parse(stdin.readLineSync()!);

        print(db2(c, v));
        break;

      case 4:
        print("Costo:");
        double c = double.parse(stdin.readLineSync()!);
        print("Valor residual:");
        double r = double.parse(stdin.readLineSync()!);
        print("Vida útil:");
        int v = int.parse(stdin.readLineSync()!);

        print(db1sl(c, r, v));
        break;

      case 5:
        print("Costo:");
        double c = double.parse(stdin.readLineSync()!);
        print("Valor residual:");
        double r = double.parse(stdin.readLineSync()!);
        print("Vida útil:");
        int v = int.parse(stdin.readLineSync()!);

        print(db2sl(c, r, v));
        break;

      case 6:
        print("Costo:");
        double c = double.parse(stdin.readLineSync()!);
        print("Valor residual:");
        double r = double.parse(stdin.readLineSync()!);
        print("Vida útil:");
        int v = int.parse(stdin.readLineSync()!);

        print(medioAnio(c, r, v));
        break;

      case 7:
        guia();
        break;

      case 8:
        print("Ingrese valores separados por coma:");
        List<double> valores = stdin
            .readLineSync()!
            .split(',')
            .map((e) => double.parse(e))
            .toList();

        print(personalizada(valores));
        break;

      default:
        print("Opción inválida");
    }
  }
}

void main() {
  menu();
}