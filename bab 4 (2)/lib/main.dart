import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Satu(),
  ));
}

class Satu extends StatefulWidget {
  const Satu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SatuState createState() => _SatuState();
}

class _SatuState extends State<Satu> {
  // Daftar item di keranjang
  List<CartItem> cartItems = [
    CartItem(
        gambar: "assets/images/gbr1.jpg",
        judul: "gambar",
        deskripsi: "gmbr",
        harga: 40,
        jumlah: 1),
    CartItem(
        gambar: "assets/images/gbr2.jpg",
        judul: "foto",
        deskripsi: "gambar",
        harga: 333,
        jumlah: 1),
    CartItem(
        gambar: "assets/images/gbr3.jpg",
        judul: "gamabr",
        deskripsi: "gambar",
        harga: 50,
        jumlah: 1),
  ];

  // Menghitung subtotal dari harga dan jumlah item
  double getSubtotal() {
    double subtotal = 0;
    for (var item in cartItems) {
      subtotal += item.harga * item.jumlah;
    }
    return subtotal;
  }

  // Menghitung diskon
  double getDiscount() {
    double subtotal = getSubtotal();
    return subtotal > 100 ? 10 : 0; // 10% discount for orders above $100
  }

  // Menghitung total setelah diskon dan biaya pengiriman
  double getTotal() {
    return getSubtotal() - getDiscount() + 5; // Adding delivery charges
  }

  // Fungsi untuk memperbarui jumlah item
  void updateItemQuantity(int index, int quantity) {
    setState(() {
      cartItems[index].jumlah = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.1),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {},
              ),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                "Cart",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.1),
                ),
                child: IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onPressed: () {},
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Menampilkan item keranjang
            Column(
              children: cartItems.map((item) {
                int index = cartItems.indexOf(item); // Mendapatkan index item
                return ListItem(
                  item: item,
                  onQuantityChanged: (quantity) {
                    updateItemQuantity(
                        index, quantity); // Memperbarui jumlah item
                  },
                );
              }).toList(),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildCheckoutDetail(
                      "Items", cartItems.length.toString(), false),
                  _buildCheckoutDetail("Subtotal",
                      "\$${getSubtotal().toStringAsFixed(2)}", false),
                  _buildCheckoutDetail("Discount",
                      "-\$${getDiscount().toStringAsFixed(2)}", true),
                  _buildCheckoutDetail("Delivery Charges", "\$5.00", false),
                  const Divider(thickness: 1, color: Colors.grey),
                  _buildCheckoutDetail(
                      "Total", "\$${getTotal().toStringAsFixed(2)}", true),
                  const SizedBox(height: 20),
                  // Tombol Checkout dengan lebar 80% dari layar, digeser ke kanan
                  Align(
                    alignment: Alignment.centerRight, // Geser ke kanan
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.9, // Lebar tombol 80% dari layar
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Proceeding to Checkout")));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 116, 3, 254), // Background color
                            foregroundColor:
                                Colors.white, // Ensure the text color is white
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          child: const Text("Check Out"),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk menampilkan detail checkout
  Widget _buildCheckoutDetail(String label, String value, bool isTotal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16,
                color: isTotal ? Colors.black : Colors.black.withOpacity(0.6)),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : Colors.black),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String gambar;
  final String judul;
  final String deskripsi;
  final int harga;
  int jumlah;

  CartItem({
    required this.gambar,
    required this.judul,
    required this.deskripsi,
    required this.harga,
    this.jumlah = 1,
  });
}

class ListItem extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged; // Callback yang menerima jumlah baru

  const ListItem(
      {super.key, required this.item, required this.onQuantityChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 160.0,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item.gambar,
                width: 100.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.judul,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    item.deskripsi,
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.7)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "\$ ${item.harga * item.jumlah}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 167, 32, 200)),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 80.0), // Geser ikon delete ke kanan
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Item dihapus")));
                    },
                  ),
                ),
                const SizedBox(height: 10), // Jarak antara ikon delete dan row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 116, 3, 254)
                            .withOpacity(0.3),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.remove,
                            size: 15, color: Colors.black),
                        onPressed: () {
                          if (item.jumlah > 0) {
                            onQuantityChanged(
                                item.jumlah - 1); // Mengurangi jumlah item
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${item.jumlah}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 116, 3, 254)
                            .withOpacity(0.3),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add,
                            size: 15, color: Colors.black),
                        onPressed: () {
                          onQuantityChanged(
                              item.jumlah + 1); // Menambah jumlah item
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
