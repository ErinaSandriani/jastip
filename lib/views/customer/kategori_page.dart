import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/traveler_viewmodel.dart';
import 'form_pesanan.dart';

class KategoriPage extends StatefulWidget {
  const KategoriPage({super.key});

  @override
  State<KategoriPage> createState() =>
      _KategoriPageState();
}

class _KategoriPageState
    extends State<KategoriPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<TravelerViewModel>()
          .getTraveler();
    });
  }

  @override
  Widget build(BuildContext context) {

    final travelerVM =
        context.watch<TravelerViewModel>();

    final categories = [

      {
        "title":"Fashion",
        "icon":Icons.checkroom,
      },

      {
        "title":"Merchandise",
        "icon":Icons.album,
      },

      {
        "title":"Skincare",
        "icon":Icons.spa,
      },

      {
        "title":"Make Up",
        "icon":Icons.face_retouching_natural,
      },

    ];

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F5F5),

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(

                "Halo 👋",

                style: TextStyle(

                  fontSize:16,

                  color: Colors.black54,
                ),
              ),

              const SizedBox(height:6),

              const Text(

                "Selamat Datang",

                style: TextStyle(

                  fontSize:28,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height:24),

              Container(

                padding:
                    const EdgeInsets.all(18),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [

                    BoxShadow(

                      color: Colors.black
                          .withOpacity(.05),

                      blurRadius:10,

                      offset:
                          const Offset(0,4),
                    ),
                  ],
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Row(

                      children: [

                        Icon(

                          Icons.flight_takeoff,

                          color:
                              Color(0xffB71C1C),
                        ),

                        SizedBox(width:8),

                        Text(

                          "Traveler Terdekat",

                          style: TextStyle(

                            fontSize:18,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height:16),

                    SizedBox(

                      height:95,

                      child:

                      travelerVM.isLoading

                          ? const Center(

                              child:
                                  CircularProgressIndicator(),
                            )

                          : ListView.builder(

                              scrollDirection:
                                  Axis.horizontal,

                              itemCount:
                                  travelerVM.travelerList.length,

                              itemBuilder:
                                  (context,index){

                                final traveler =
                                    travelerVM
                                        .travelerList[index];

                                return Container(

                                  width:220,

                                  margin:
                                      const EdgeInsets.only(
                                    right:12,
                                  ),

                                  padding:
                                      const EdgeInsets.all(
                                    14,
                                  ),

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        const Color(
                                            0xffFDECEC),

                                    borderRadius:
                                        BorderRadius.circular(
                                      16,
                                    ),
                                  ),

                                  child: Column(

                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    mainAxisAlignment:
                                        MainAxisAlignment.center,

                                    children: [

                                      Text(

                                        traveler.nama,

                                        style:
                                            const TextStyle(

                                          fontWeight:
                                              FontWeight.bold,

                                          fontSize:16,
                                        ),
                                      ),

                                      const SizedBox(height:6),

                                      Text(

                                        traveler.tanggalPulang,

                                        style:
                                            const TextStyle(

                                          color:
                                              Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height:28),

              const Text(

                "Aktivitas Saya",

                style: TextStyle(

                  fontSize:20,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height:16),

              SizedBox(

  height: 82,

  child: Row(

    children: [

      Expanded(
        child: _statCard(
          "12",
          "Pesanan",
          Icons.shopping_bag,
        ),
      ),

      const SizedBox(width:10),

      Expanded(
        child: _statCard(
          "2",
          "Pending",
          Icons.pending_actions,
        ),
      ),

      const SizedBox(width:10),

      Expanded(
        child: _statCard(
          "3",
          "Proses",
          Icons.local_shipping,
        ),
      ),

      const SizedBox(width:10),

      Expanded(
        child: _statCard(
          "9",
          "Selesai",
          Icons.check_circle,
        ),
      ),
    ],
  ),
),

const SizedBox(height:28),

const Text(

  "Pilih Jenis Titipan",

  style: TextStyle(

    fontSize:20,

    fontWeight:
        FontWeight.bold,
  ),
),

const SizedBox(height:16),

GridView.builder(

  shrinkWrap: true,

  physics:
      const NeverScrollableScrollPhysics(),

  itemCount:
      categories.length,

  gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(

    crossAxisCount:2,

    crossAxisSpacing:14,

    mainAxisSpacing:14,

    childAspectRatio:.95,
  ),

  itemBuilder:
      (context,index){

    final item =
        categories[index];

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        20,
      ),

      onTap:(){

        Navigator.push(

          context,

          MaterialPageRoute(

            builder:(_)=>

                FormPesananPage(

              kategori:

                  item["title"]
                      as String,
            ),
          ),
        );
      },

      child: Container(

        decoration:
            BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            20,
          ),

          boxShadow:[

            BoxShadow(

              color: Colors.black
                  .withOpacity(.04),

              blurRadius:8,

              offset:
                  const Offset(0,3),
            )
          ],
        ),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children:[

            CircleAvatar(

              radius:26,

              backgroundColor:
                  const Color(
                      0xffFDECEC),

              child: Icon(

                item["icon"]
                    as IconData,

                color:
                    const Color(
                        0xffB71C1C),

                size:26,
              ),
            ),

            const SizedBox(
                height:12),

            Text(

              item["title"]
                  as String,

              style:
                  const TextStyle(

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  },
),

const SizedBox(height:30),

],
),
),
),
);
}

Widget _statCard(

String value,

String title,

IconData icon,

){

return Container(

decoration: BoxDecoration(

color: Colors.white,

borderRadius:
BorderRadius.circular(18),

boxShadow:[

BoxShadow(

color:
Colors.black.withOpacity(.04),

blurRadius:8,

offset:
const Offset(0,3),
)
],
),

child: Column(

mainAxisAlignment:
MainAxisAlignment.center,

children:[

Icon(

icon,

size:20,

color:
const Color(
0xffB71C1C),
),

const SizedBox(
height:6),

Text(

value,

style:
const TextStyle(

fontSize:17,

fontWeight:
FontWeight.bold,

color:
Color(0xffB71C1C),
),
),

Text(

title,

textAlign:
TextAlign.center,

style:
const TextStyle(

fontSize:10,

color:
Colors.black54,
),
),
],
),
);
}
}