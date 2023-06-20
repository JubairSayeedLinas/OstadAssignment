import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      debugShowCheckedModeBanner: false,
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10.0),
    Product(name: 'Product 2', price: 20.0),
    Product(name: 'Product 3', price: 30.0),
    Product(name: 'Product 4', price: 40.0),
    Product(name: 'Product 5', price: 50.0),
    Product(name: 'Product 6', price: 60.0),
    Product(name: 'Product 7', price: 70.0),
    Product(name: 'Product 8', price: 80.0),
    Product(name: 'Product 9', price: 90.0),

  ];

  void showCongratulationsDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Congratulations!'),
        content: Text("You've bought 5 ${product.name}!"),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(products[index].name),
                subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
                trailing: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Counter: ${products[index].counter}'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            products[index].counter++;
                            if (products[index].counter == 5) {
                              showCongratulationsDialog(products[index]);
                            }
                          });
                        },
                        child: Text('Buy Now'),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(products: products)),
          );
        },
      ),
    );
  }

  int getTotalBoughtProducts() {
    int total = 0;
    for (var product in products) {
      total += product.counter;
    }
    return total;
  }
}

class Product {
  final String name;
  final double price;
  int counter;

  Product({required this.name, required this.price, this.counter = 0});
}

class CounterText extends StatelessWidget {
  final int count;

  CounterText({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      child: Center(
        child: Text(
          count.toString(),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  int getTotalBoughtProducts() {
    int total = 0;
    for (var product in products) {
      total += product.counter;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total bought products: ${getTotalBoughtProducts()}'),
      ),
    );
  }
}
