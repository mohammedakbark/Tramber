import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/drop_menu/bucket_list.dart';
import 'package:tramber/View/modules/user/profile/profile.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/ViewModel/get_locatiion.dart';
import 'package:tramber/utils/image.dart';

class HotelDetailPage extends StatelessWidget {
  String placeId;
  String hotelId;
  HotelDetailPage({super.key, required this.hotelId, required this.placeId});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<Firestore>(builder: (context, firestore, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: PopupMenuButton(
            icon: const Icon(CupertinoIcons
                .list_dash), //don't specify icon if you want 3 dot menu
            color: HexColor("#055C9D"),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const HomePage()));
                },
                value: 0,
                child: Text(
                  "Home",
                  style: GoogleFonts.niramit(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              PopupMenuItem<int>(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BucketList()));
                },
                value: 1,
                child: Row(
                  children: [
                    Text(
                      "Bucket List    ",
                      style: GoogleFonts.niramit(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.bookmark,
                      color: Colors.white,
                      size: 18,
                    )
                  ],
                ),
              ),
              // PopupMenuItem<int>(
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => AddPlace()));
              //     },
              //     value: 2,
              //     child: Text(
              //       "Add a Place",
              //       style: GoogleFonts.niramit(
              //         color: Colors.white,
              //         fontSize: 16,
              //       ),
              //     )),
              PopupMenuItem<int>(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HomePage()));
                  },
                  value: 3,
                  child: Text(
                    "Help",
                    style: GoogleFonts.niramit(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
            ],
            onSelected: (item) => {print(item)},
          ),
          title: Consumer<LocationPrvider>(builder: (context, locpro, child) {
            return SizedBox(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  CupertinoIcons.placemark,
                  size: 16,
                ),
                Text(
                  "${locpro.place ?? ""}",
                  style: GoogleFonts.niramit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                const Text("|"),
                Text(
                  "${locpro.country ?? ""}",
                  style: GoogleFonts.niramit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ]),
            );
          }),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const profile()));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: firestore.userModel?.profileimage == ""
                            ? imageNotFound
                            : NetworkImage(
                                "${firestore.userModel?.profileimage}"))),
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future: firestore.fetchSelectedHotelDetails(placeId, hotelId),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final hotel = firestore.selectedhotel;
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: height * .3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(hotel!.image),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hotel.hotelName.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 22),
                        ),
                        Row(
                          children: [
                            Text(
                              hotel.price.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(79, 39, 255, 0.622)),
                            ),
                            const Text(
                              "/night",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: Color.fromRGBO(72, 31, 255, 0.62),
                            ),
                            Text(
                              hotel.location.characters.first.toUpperCase() +
                                  hotel.location.substring(1),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: width / 3.4,
                            height: 30,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () async {
                                  await MapsLauncher.launchQuery(
                                      hotel.location);
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "Location",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    const Text(
                      "Description",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    SizedBox(
                      child: Text(
                        hotel.description,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Text(
                      "Preview",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    // Container(
                    //   color: Colors.amber,
                    //   width: width,
                    //   height: height * .2,
                    //   child: ListView.builder(
                    //     itemBuilder: (context, index) {
                    //       return Container(
                    //         decoration: BoxDecoration(
                    //             color: Colors.red,
                    //             borderRadius: BorderRadius.circular(10)),
                    //       );
                    //     },
                    //   ),
                    // child:
                    // )
                  ],
                ),
              );
            }),
      );
    });
  }
}
