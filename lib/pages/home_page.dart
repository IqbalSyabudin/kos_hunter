import 'package:flutter/material.dart';
import 'package:kos_hunter/models/city.dart';
import 'package:kos_hunter/models/space.dart';
import 'package:kos_hunter/models/tips.dart';
import 'package:kos_hunter/theme.dart';
import 'package:kos_hunter/widgets/bottom_navbar_item.dart';
import 'package:kos_hunter/widgets/city_card.dart';
import 'package:kos_hunter/widgets/space_card.dart';
import 'package:kos_hunter/widgets/tips_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'edit_profile_page.dart'; 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;

  List<City> cities = [];
  List<Space> spaces = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final cityRes = await supabase.from('cities').select();
      final spaceRes = await supabase.from('kosts').select();

      setState(() {
        cities = (cityRes as List).map((e) => City.fromMap(e)).toList();
        spaces = (spaceRes as List).map((e) => Space.fromMap(e)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SizedBox(height: edge),
                  // Header
                  Padding(
                    padding: EdgeInsets.only(left: edge),
                    child: Text(
                      'Explore Now',
                      style: blackTextStyle.copyWith(fontSize: 24),
                    ),
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: EdgeInsets.only(left: edge),
                    child: Text(
                      'Cari kosan yang Kalcer?',
                      style: greyTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Popular Cities
                  Padding(
                    padding: EdgeInsets.only(left: edge),
                    child: Text(
                      'Popular Cities',
                      style: regularTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: cities.map((city) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: city == cities.first ? 24 : 20,
                            right: city == cities.last ? 24 : 0,
                          ),
                          child: CityCard(city),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Recommended Spaces
                  Padding(
                    padding: EdgeInsets.only(left: edge),
                    child: Text(
                      'Recommended Space',
                      style: greyTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: edge),
                    child: Column(
                      children: spaces.map((space) {
                        return Column(
                          children: [
                            SpaceCard(space),
                            SizedBox(height: 30),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Tips & Guidance
                  Padding(
                    padding: EdgeInsets.only(left: edge),
                    child: Text(
                      'Tips & Guidance',
                      style: greyTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: edge),
                    child: Column(
                      children: [
                        TipsCard(
                          Tips(
                            id: 1,
                            title: 'Panduan Kota',
                            imageUrl: 'assets/icon_2.png',
                            updateAt: '20 Apr',
                          ),
                        ),
                        SizedBox(height: 20),
                        TipsCard(
                          Tips(
                            id: 2,
                            title: 'Surakarta Fairship',
                            imageUrl: 'assets/icon_3.png',
                            updateAt: '11 Dec',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50 + edge),
                ],
              ),
      ),
      floatingActionButton: Container(
        height: 65,
        width: MediaQuery.of(context).size.width - (2 * edge),
        margin: EdgeInsets.symmetric(horizontal: edge),
        decoration: BoxDecoration(
          color: Color(0xffF6F7F8),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavbarItem(
              imageUrl: 'assets/Icon_home_solid.png',
              isActive: true,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/Icon_mail_solid.png',
              isActive: false,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/Icon_card_solid.png',
              isActive: false,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/Icon_love_solid.png',
              isActive: false,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
