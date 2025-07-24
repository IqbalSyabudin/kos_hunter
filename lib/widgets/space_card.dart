import 'package:flutter/material.dart';
import 'package:kos_hunter/models/space.dart';
import 'package:kos_hunter/pages/detail_page.dart';
import 'package:kos_hunter/theme.dart';

class SpaceCard extends StatelessWidget {
  final Space space;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;

  SpaceCard({
    required this.space,
    required this.isFavorited,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              space: space,
              isFavorited: isFavorited,
              onFavoriteToggle: onFavoriteToggle,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: 130,
                height: 110,
                child: Stack(
                  children: [
                    Image.network(
                      space.imageUrl,
                      width: 130,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 20),
                            SizedBox(width: 2),
                            Text(
                              '${space.rating}/5',
                              style: whiteTextStyle.copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    space.name,
                    style: blackTextStyle.copyWith(fontSize: 18),
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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${space.city}, ${space.country}',
                        style: greyTextStyle,
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: isFavorited ? Colors.red : Colors.grey,
                        ),
                        onPressed: onFavoriteToggle,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
