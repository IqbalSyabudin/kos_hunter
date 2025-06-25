import 'package:bwa_coyz/theme.dart';
import 'package:bwa_coyz/widgets/facility.item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void launchUrlString(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Tidak bisa membuka URL: $url';
      }
    }


    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset('assets/pic_18.png',
            width: MediaQuery.of(context).size.width,
            height: 350,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                SizedBox(
                  height: 328,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      // NOTE: TITLE
                      Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: edge,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Pondok Berseri',
                                style: blackTextStyle.copyWith(
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: '\$52',
                                  style: purpleTextStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '/ month',
                                      style: greyTextStyle.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/Icon_star_solid.png',
                                width: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'assets/Icon_star_solid.png',
                                width: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'assets/Icon_star_solid.png',
                                width: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'assets/Icon_star_solid.png',
                                width: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'assets/Icon_star_solid.png',
                                width: 20,
                                color: Color(0xff989BA1),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // NOTE: MAIN FACILITIES
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Main Facilities',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(padding: EdgeInsets.symmetric(
                        horizontal: edge,
                      ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FacilityItem(
                              name: 'kitchen',
                              imageUrl: 'assets/001_bar_counter.png',
                              total: 2,
                            ),
                            FacilityItem(
                              name: 'bedroom',
                              imageUrl: 'assets/002_double_bed.png',
                              total: 3,
                            ),
                            FacilityItem(
                              name: 'Big Lemari',
                              imageUrl: 'assets/003_cupboard.png',
                              total: 3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // NOTE: PHOTO
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Photos',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 88,
                       child: ListView(
                         scrollDirection: Axis.horizontal,
                         children: [
                           SizedBox(
                             width: edge,
                           ),
                             Image.asset(
                             'assets/pic_19.png',
                             width: 110,
                             height: 88,
                             fit: BoxFit.cover,
                           ),
                           SizedBox(
                             width: 18,
                           ),
                           Image.asset(
                             'assets/pic_20.png',
                             width: 110,
                             height: 88,
                             fit: BoxFit.cover,
                           ),
                           SizedBox(
                             width: 18,
                           ),
                           Image.asset(
                             'assets/pic_22.png',
                             width: 110,
                             height: 88,
                             fit: BoxFit.cover,
                           ),
                           SizedBox(
                             width: edge,
                           ),
                         ],
                       ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // NOTE: LOCATION
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Location',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Jln. Kappan Sukses No. 20\nSurakarta',
                              style: greyTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                launchUrl(Uri.parse('https://goo.gl/maps/SyZx2yjWB1yR6AeH8'));
                              },
                              child: Image.asset(
                                  'assets/btn_wishlist_1.png',
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: edge,
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width - (2 * edge),
                        child: ElevatedButton(
                          onPressed: () {
                            launchUrl(Uri.parse('tel:+6888239453717'));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edge,
                vertical: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/btn_back.png',
                      width: 40,
                    ),
                  ),
                  Image.asset(
                    'assets/btn_wishlist.png',
                    width: 40,
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
