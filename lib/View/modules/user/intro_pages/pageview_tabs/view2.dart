import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class View2 extends StatefulWidget {
  const View2({super.key});

  @override
  State<View2> createState() => _View2State();
}

class _View2State extends State<View2> {
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: hight * .6,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2018/09/08/22/07/paris-3663435_640.jpg'))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Stack(
              children: [
                Text(
                  "Life is short and ",
                  style: GoogleFonts.marcellusSc(
                      color: Colors.black, fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    "\t World is wide",
                    style: GoogleFonts.marcellusSc(
                        color: Colors.black, fontSize: 40),
                  ),
                )
              ],
            ),
          ),
          Text(
            "Tramper allows it’s users to have",
            style: GoogleFonts.niramit(color: Colors.black, fontSize: 16),
          ),
          Text(
            "a hassle free travel experience",
            style: GoogleFonts.niramit(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
