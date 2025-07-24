import 'package:flutter/material.dart';
import 'package:kos_hunter/models/space.dart';
import 'package:kos_hunter/theme.dart';
import 'package:kos_hunter/widgets/facility_item.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final Space space;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;

  DetailPage({
    required this.space,
    required this.isFavorited,
    required this.onFavoriteToggle,
  });

  void launchUrlString(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Tidak bisa membuka URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.network(
              space.imageUrl,
              width: MediaQuery.of(context).size.width,
              height: 350,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                SizedBox(height: 328),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: edge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Nama dan harga
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  space.name,
                                  style: blackTextStyle.copyWith(fontSize: 22),
                                ),
                                SizedBox(height: 2),
                                Text.rich(
                                  TextSpan(
                                    text: 'Rp ${space.price}',
                                    style: purpleTextStyle.copyWith(fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: ' / month',
                                        style: greyTextStyle.copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 20,
                                  color: index < space.rating
                                      ? Colors.amber
                                      : Color(0xff989BA1),
                                );
                              }),
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        Text('Main Facilities', style: regularTextStyle.copyWith(fontSize: 16)),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FacilityItem(name: 'kitchen', imageUrl: 'assets/001_bar_counter.png', total: 2),
                            FacilityItem(name: 'bedroom', imageUrl: 'assets/002_double_bed.png', total: 3),
                            FacilityItem(name: 'Big Lemari', imageUrl: 'assets/003_cupboard.png', total: 3),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text('Location', style: regularTextStyle.copyWith(fontSize: 16)),
                        SizedBox(height: 6),
                        Text(
                          '${space.city}, ${space.country}',
                          style: greyTextStyle,
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              launchUrlString('tel:+62888239453717');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: Text(
                              'Book Now',
                              style: whiteTextStyle.copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol kembali
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.red : Colors.white,
                    ),
                    onPressed: onFavoriteToggle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
