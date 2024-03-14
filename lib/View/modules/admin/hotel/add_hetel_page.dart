import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/Model/hotel_model.dart';
import 'package:tramber/View/modules/admin/hotel/view_exissting_hotels.dart';
import 'package:tramber/View/modules/admin/restaurents/view_exissting_rest.dart';
import 'package:tramber/ViewModel/controll_provider.dart';
import 'package:tramber/ViewModel/pick_image.dart';
import 'package:tramber/utils/variables.dart';

class AddHotelsPage extends StatelessWidget {
  String placeId;
  String locationName;
  AddHotelsPage({super.key, required this.placeId, required this.locationName});
  String? image;
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController hotelNmae = TextEditingController();
  TextEditingController price = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Hotel",
            style: GoogleFonts.poppins(fontSize: 26),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewHotelsFromSelectedPlace(
                          Place: locationName,
                          placeId: placeId,
                        ),
                      ));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  "View Existing Hotels",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Consumer<Controller>(builder: (context, controller, child) {
          return SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: height,
                width: width,
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .07,
                          width: MediaQuery.of(context).size.width * .5,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return " Hoetel Name is required";
                              } else {
                                return null;
                              }
                            },
                            maxLines: 1,
                            controller: hotelNmae,
                            decoration: const InputDecoration(
                              hintText: "Add Hotel Name",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(5, 92, 157, 0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4.8,
                        // width: MediaQuery.of(context).size.width / 1.13,
                        decoration: BoxDecoration(
                          color: image == null
                              ? const Color.fromRGBO(104, 187, 227, 0.5)
                              : Colors.transparent,
                          image: DecorationImage(
                              image: image != null
                                  ? FileImage(imageFilePlace!)
                                  : const AssetImage('asset/images.jpeg')
                                      as ImageProvider<Object>,
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.black, style: BorderStyle.solid),
                        ),
                        child: InkWell(
                          onTap: () async {
                            controller.imageIsLoading(true);
                            await addHotelImage().then((value) {
                              image = value;
                              controller.imageIsLoading(false);
                            });
                          },
                          child: controller.isImageLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined),
                                    Text("ADD IMAGE"),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4.8,
                        // width: MediaQuery.of(context).size.width / 1.13,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "write somthing about this Hotel ";
                            } else {
                              return null;
                            }
                          },
                          maxLines: 7,
                          controller: description,
                          decoration: const InputDecoration(
                            hintText: "Tell us something about this Hotel",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(5, 92, 157, 0)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .07,
                          width: MediaQuery.of(context).size.width * .5,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "location is requiered ";
                              } else {
                                return null;
                              }
                            },
                            maxLines: 1,
                            controller: location,
                            decoration: const InputDecoration(
                              hintText: "Add Location",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(5, 92, 157, 0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .07,
                          width: MediaQuery.of(context).size.width * .5,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Price is required ";
                              } else {
                                return null;
                              }
                            },
                            maxLines: 1,
                            controller: price,
                            decoration: const InputDecoration(
                              hintText: "Price",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(5, 92, 157, 0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Pick Image ")));
                              } else {
                                storenstence.addHotels(
                                    placeId,
                                    HotelModel(
                                        category: "Hotel",
                                        description: description.text,
                                        image: image!,
                                        hotelName: hotelNmae.text,
                                        location: location.text,
                                        price: price.text));

                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: const Color.fromARGB(
                                              171, 0, 0, 0),
                                          title: const Text(
                                            "Hotel added Successfully",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    167, 255, 255, 255)),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewHotelsFromSelectedPlace(
                                                                Place:
                                                                    locationName,
                                                                placeId:
                                                                    placeId,
                                                              )));
                                                },
                                                child: const Text(
                                                  "OK",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        ));
                              }

                              print("object");
                            }

                            // storenstence.addHotels(placeId, HotelModel(category: category, description: description, image: image, latitude: latitude, longitude: longitude, location: location, price: price))
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          child: Text(
                            "Add hotel",
                            style: TextStyle(color: Colors.white),
                          ))
                    ]))),
          );
        }));
  }
}
