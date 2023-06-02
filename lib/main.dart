import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//Inicio
class _MyHomePageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    // Redireccionar a MyHomePage después de 5 segundos
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '©2023 Avalom.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Home
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Acción para volver atrás
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Logo y nombre del negocio
            Container(
              color: Colors.grey,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  // Logo
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    // Aca poner logo
                  ),
                  SizedBox(width: 16),
                  // Nombre del negocio
                  Text(
                    'Lo de Vero',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Botones
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Botón: Lista de precios
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        fixedSize: Size(312, 105),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PriceListPage()),
                        );
                      },
                      child: Text('Lista de precios'),
                    ),
                    SizedBox(height: 16),

                    // Botón: Caja
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        fixedSize: Size(312, 105),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Caja()),
                        );
                      },
                      child: Text('Caja'),
                    ),
                    SizedBox(height: 16),

                    // Botón: Porcentajes
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        fixedSize: Size(312, 105),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Porcentajes()),
                        );
                      },
                      child: Text('Porcentajes'),
                    ),
                    SizedBox(height: 16),

                    // Botón: Balance general
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        fixedSize: Size(312, 105),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BalanceGeneralPage(
                              transactionsOfDay: [], // Reemplaza con la lista de transacciones del día correspondiente
                              currentDate: DateFormat('dd/MM/yyyy').format(DateTime
                                  .now()), // Obtiene la fecha actual en el formato deseado
                            ),
                          ),
                        );
                      },
                      child: Text('Balance general'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Lista de precios
class PriceListPage extends StatefulWidget {
  @override
  _PriceListPageState createState() => _PriceListPageState();
}

class _PriceListPageState extends State<PriceListPage> {
  List<String> products = [];
  List<String> prices = [];

  final productController = TextEditingController();
  final priceController = TextEditingController();
  String searchKeyword = '';

  @override
  void dispose() {
    productController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void addProduct(String product, String price) {
    setState(() {
      products.add(product);
      prices.add(price);
      productController.clear();
      priceController.clear();
      searchKeyword = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredProducts = products
        .where((product) =>
            product.toLowerCase().contains(searchKeyword.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Precios'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            // Agregar producto
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: productController,
                decoration: InputDecoration(
                  labelText: 'Agregar producto',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Agregar precio
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Agregar precio',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Botón Agregar
            ElevatedButton(
              onPressed: () {
                String product = productController.text;
                String price = priceController.text;
                if (product.isNotEmpty && price.isNotEmpty) {
                  addProduct(product, price);
                }
              },
              child: Text('Agregar'),
            ),
            SizedBox(height: 16),

            // Barra de búsqueda
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchKeyword = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Buscar producto',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Lista de productos y precios
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  String product = filteredProducts[index];
                  String price = prices[products.indexOf(product)];
                  return ListTile(
                    title: Text(product),
                    subtitle: TextFormField(
                      initialValue: price,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          prices[products.indexOf(product)] = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Caja
class Caja extends StatefulWidget {
  @override
  _CajaState createState() => _CajaState();
}

class _CajaState extends State<Caja> {
  List<Transaction> transactions = [];
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  String selectedPaymentMethod = 'Efectivo';
  String selectedTransactionType = 'Entrada';
  DateTime currentDate = DateTime.now();
  List<Transaction> transactionsOfDay = [];

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void addTransaction() {
    String date = dateController.text;
    double amount = double.tryParse(amountController.text) ?? 0;

    setState(() {
      transactions.add(Transaction(
        date: date,
        amount: amount,
        type: selectedTransactionType,
        paymentMethod: selectedPaymentMethod,
      ));

      if (DateFormat('dd/MM/yyyy').format(DateTime.now()) == date) {
        transactionsOfDay.add(Transaction(
          date: date,
          amount: amount,
          type: selectedTransactionType,
          paymentMethod: selectedPaymentMethod,
        ));
      }

      dateController.clear();
      amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caja'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Fecha
            Text(
              'Fecha: ${DateFormat('dd/MM/yyyy').format(currentDate)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            // Monto
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monto',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Tipo de transacción
            DropdownButtonFormField<String>(
              value: selectedTransactionType,
              onChanged: (newValue) {
                setState(() {
                  selectedTransactionType = newValue!;
                });
              },
              items: ['Entrada', 'Salida']
                  .map((type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Tipo de transacción',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Forma de pago
            DropdownButtonFormField<String>(
              value: selectedPaymentMethod,
              onChanged: (newValue) {
                setState(() {
                  selectedPaymentMethod = newValue!;
                });
              },
              items: ['Efectivo', 'Transferencia']
                  .map((method) => DropdownMenuItem<String>(
                        value: method,
                        child: Text(method),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Forma de pago',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Botón Agregar
            ElevatedButton(
              onPressed: addTransaction,
              child: Text('Agregar'),
            ),

            SizedBox(height: 16),

            // Lista de transacciones
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  Transaction transaction = transactions[index];
                  Color textColor =
                      transaction.type == 'Entrada' ? Colors.green : Colors.red;
                  return ListTile(
                    title: Text(
                      'Monto: \$${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(color: textColor),
                    ),
                    subtitle: Text(
                      'Tipo: ${transaction.type}, Forma de pago: ${transaction.paymentMethod}',
                      style: TextStyle(color: textColor),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String date;
  final double amount;
  final String type;
  final String paymentMethod;

  Transaction({
    required this.date,
    required this.amount,
    required this.type,
    required this.paymentMethod,
  });
}

//Porcentajes
class Income {
  final String date;
  final double amount;
  final String paymentMethod;

  Income(
      {required this.date, required this.amount, required this.paymentMethod});
}

class Porcentajes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Porcentajes'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 255, 254, 254),
          ),
          onPressed: () {
            Navigator.pop(context);
            // Acción para volver atrás
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón: Producto Elaborado
              Container(
                width: 319,
                height: 105,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductoElaborado(),
                      ),
                    );
                  },
                  child: Text('Producto Elaborado'),
                ),
              ),
              SizedBox(height: 16),

              // Botón: Producto Comprado
              Container(
                width: 319,
                height: 105,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductoComprado(),
                      ),
                    );
                  },
                  child: Text('Producto Comprado'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Producto Elaborado
//Esta parte no anda, no saca bien el porcentaje o no Imprime.
class ProductoElaborado extends StatefulWidget {
  @override
  _ProductoElaboradoState createState() => _ProductoElaboradoState();
}

class _ProductoElaboradoState extends State<ProductoElaborado> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  double totalIngredients = 0.0;
  double percentageResult = 0.0;
  List<double> ingredientAmounts = [];
  List<TextEditingController> ingredientControllers = [];

  void addIngredient() {
    double ingredientAmount = double.tryParse(ingredientController.text) ?? 0.0;
    setState(() {
      totalIngredients += ingredientAmount;
      ingredientAmounts.add(ingredientAmount);
      ingredientControllers.add(TextEditingController());
      ingredientController.clear();
    });
  }

  void calculatePercentage() {
    double percentage = double.tryParse(percentageController.text) ?? 0.0;
    double sumOfIngredients = ingredientAmounts.fold(0.0, (a, b) => a + b);
    double totalAmount = sumOfIngredients * (1 + (percentage / 100));
    setState(() {
      percentageResult = totalAmount;
    });
  }

  void reset() {
    setState(() {
      nameController.clear();
      ingredientController.clear();
      percentageController.clear();
      totalIngredients = 0.0;
      percentageResult = 0.0;
      ingredientAmounts.clear();
      ingredientControllers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto Elaborado'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Agregar nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            for (int i = 0; i < ingredientControllers.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: ingredientControllers[i],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Precio Ingrediente ${i + 1}',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: addIngredient,
              child: Text('Agregar ingrediente'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: percentageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Agregar porcentaje',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculatePercentage,
              child: Text('Sacar porcentaje'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Resultado del porcentaje: ${percentageResult.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nombre del producto: ${nameController.text}',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: reset,
              child: Text('Sacar nuevo porcentaje'),
            ),
          ],
        ),
      ),
    );
  }
}

// Producto Comprado
class ProductoComprado extends StatefulWidget {
  @override
  _ProductoCompradoState createState() => _ProductoCompradoState();
}

class _ProductoCompradoState extends State<ProductoComprado> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController percentageController = TextEditingController();

  double totalAmount = 0.0;
  String productName = '';
  double result = 0.0;

  void calculatePercentage() {
    setState(() {
      double amount = double.tryParse(amountController.text) ?? 0.0;
      double percentage = double.tryParse(percentageController.text) ?? 0.0;

      totalAmount = amount;
      result = amount * (1 + (percentage / 100));

      amountController.clear();
      percentageController.clear();
    });
  }

  void addToPriceList() {
    String productName = productNameController.text;
    double price = result;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PriceListPage(),
        settings: RouteSettings(
          arguments: {
            'productName': productName,
            'price': price.toString(),
          },
        ),
      ),
    );

    setState(() {
      productNameController.clear();
      amountController.clear();
      percentageController.clear();
      totalAmount = 0.0;
      productName = '';
      result = 0.0;
    });
  }

  void resetPage() {
    setState(() {
      productNameController.clear();
      amountController.clear();
      percentageController.clear();
      totalAmount = 0.0;
      productName = '';
      result = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto Comprado'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: productNameController,
              decoration: InputDecoration(
                labelText: 'Agregar nombre de producto',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  productName = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Agregar monto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: percentageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Agregar porcentaje',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                calculatePercentage();
              },
              child: Text('Sacar porcentaje'),
            ),
            SizedBox(height: 16),
            Text('Nombre del producto: $productName'),
            Text('Resultado: $result'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                addToPriceList();
              },
              child: Text('Agregar a lista de precios'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                resetPage();
              },
              child: Text('Iniciar nuevo porcentaje'),
            ),
          ],
        ),
      ),
    );
  }
}

// Balance General
//Esta parte hay que hacer despues que los datos que se vayan almacenando en "Caja" pasen como PDF aca para ser descargados o cualquier otro tipo de archivo.
class BalanceGeneralPage extends StatefulWidget {
  final List<Transaction> transactionsOfDay;
  final String currentDate;

  BalanceGeneralPage(
      {required this.transactionsOfDay, required this.currentDate});

  @override
  _BalanceGeneralPageState createState() => _BalanceGeneralPageState();
}

class _BalanceGeneralPageState extends State<BalanceGeneralPage> {
  String searchKeyword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Balance general'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Acción para volver atrás
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            // Barra de búsqueda
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchKeyword = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Buscar balance',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Fecha
            Text(
              'Fecha: ${widget.currentDate}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            // Lista de transacciones
            Expanded(
              child: ListView.builder(
                itemCount: widget.transactionsOfDay.length,
                itemBuilder: (context, index) {
                  Transaction transaction = widget.transactionsOfDay[index];
                  Color textColor =
                      transaction.type == 'Entrada' ? Colors.green : Colors.red;
                  return ListTile(
                    title: Text(
                      'Monto: \$${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(color: textColor),
                    ),
                    subtitle: Text(
                      'Tipo: ${transaction.type}, Forma de pago: ${transaction.paymentMethod}',
                      style: TextStyle(color: textColor),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
