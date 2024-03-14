import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/admin/hotel/add_hetel_page.dart';
import 'package:tramber/View/modules/admin/restaurents/add_restaurents.dart';
import 'package:tramber/ViewModel/firestore.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider.of<Firestore>(context, listen: false).fetchAllPlaces();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Places",
          style: GoogleFonts.poppins(fontSize: 26),
        ),
      ),
      body: Consumer<Firestore>(builder: (context, firestore, child) {
        final list = firestore.placeList;
        return FutureBuilder(
            future: firestore.fetchAllPlaces(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                width: width,
                height: height,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .65,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                firestore.deletePlacefromFirestore(
                                    list[index].placeID);
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              )),
                          Card(
                            child: Column(
                              children: [
                                Text(
                                  list[index].location,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Divider(),
                                SizedBox(
                                    height: height * .1,
                                    width: width * .35,
                                    child: Image.network(
                                      list[index].image,
                                      fit: BoxFit.fill,
                                    )),
                                SizedBox(
                                    width: width * .35,
                                    child: Text(
                                      list[index].description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddHotelsPage(
                                                locationName:
                                                    list[index].location,
                                                placeId:
                                                    "${list[index].placeID}")));
                                  },
                                  child: const Text(
                                    "Add Hotels",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddRestaurentsPage(
                                                    locationName:
                                                        list[index].location,
                                                    placeId:
                                                        "${list[index].placeID}")));
                                  },
                                  child: const Text(
                                    "Add Restaurents",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: list.length),
              );
            });
      }),
    );
  }
}
