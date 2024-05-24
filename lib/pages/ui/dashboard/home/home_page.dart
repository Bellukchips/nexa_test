import 'package:flutter/material.dart';

import 'package:nexa_test/models/doctor/doctor_model.dart';
import 'package:nexa_test/services/doctor_service.dart';
import 'package:nexa_test/shared/assets.dart';
import 'package:nexa_test/shared/color_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<DoctorModel>> _doctorListFuture;

  @override
  void initState() {
    _fetchDoctorList();
    super.initState();
  }

  Future<void> _fetchDoctorList() async {
    try {
      _doctorListFuture = DoctorService.getNearbyDoctor();
    } catch (e) {
      // Handle error if any
      print('Error fetching doctor list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //!Header
              const HeaderHomePage(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! Card
                      const CardGeneralPractitioners(),
                      //! Form Search
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        cursorColor: ColorApp.primaryColor,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: Image.asset(
                              IconAssets.get(IconAssets.search),
                            ),
                            fillColor: const Color(0xffFAFAFA),
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 151, 151, 151),
                            ),
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 151, 151, 151),
                            ),
                            filled: true,
                            hintText: 'Cari Dokter Spesialis',
                            labelText: "Cari Dokter Spesialis",
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffFAFAFA)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    width: 0, color: Color(0xffFAFAFA)))),
                      ),
                      //! Group Menu App
                      const SizedBox(
                        height: 25,
                      ),
                      const GroupMenuHomePage(),
                      //! Nearest doctor
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Dokter Terdekat',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<List<DoctorModel>>(
                        future: _doctorListFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.blue),
                                ),
                              ),
                            );
                          } else if (snapshot.hasError ||
                              snapshot.data == null) {
                            return const Center(
                              child: Text(
                                  'Error fetching doctor list. Please try again later.'),
                            );
                          } else {
                            List<DoctorModel>? doctorList = snapshot.data;
                            if (doctorList!.isEmpty) {
                              return const Expanded(
                                child: Center(
                                  child: Text('No nearby doctors found.'),
                                ),
                              );
                            } else {
                              return SizedBox(
                                height: 145 * doctorList.length + 200,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: doctorList.length,
                                  itemBuilder: (context, index) {
                                    DoctorModel doctor = doctorList[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: (index == doctorList.length - 1)
                                            ? 100
                                            : 10,
                                      ),
                                      child: CardNearestDoctor(model: doctor),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardNearestDoctor extends StatelessWidget {
  final DoctorModel model;
  const CardNearestDoctor({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color:
                  const Color.fromARGB(255, 225, 225, 225).withOpacity(0.5), //
              spreadRadius: 1,
              blurRadius: 15),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              ImageAssets.get(ImageAssets.imgSampleDr),
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.nama,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          model.jenis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            color: Color.fromARGB(204, 119, 119, 119),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      model.jarak!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),

            //! Line
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 1.0, //
              width: double.infinity, //
              color: const Color.fromARGB(143, 217, 217, 217),
            ),

            //! Available Date Time
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! Reviews
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Color(0xffFEB052),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '4,8 (120 Reviews)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xffFEB052),
                      ),
                    )
                  ],
                ),
                //! Open at
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Open at 17.00',
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GroupMenuHomePage extends StatelessWidget {
  const GroupMenuHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 72,
              width: 72,
              alignment: FractionalOffset.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFAFAFA),
              ),
              child: Image.asset(IconAssets.get(IconAssets.doctorMenu)),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              'Dokter',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 137, 137, 137)),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 72,
              width: 72,
              alignment: FractionalOffset.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFAFAFA),
              ),
              child: Image.asset(IconAssets.get(IconAssets.drug)),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              'Obat & Resep',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 137, 137, 137)),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 72,
              width: 72,
              alignment: FractionalOffset.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFAFAFA),
              ),
              child: Image.asset(IconAssets.get(IconAssets.hospital)),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              'Rumah Sakit',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 137, 137, 137)),
            )
          ],
        ),
      ],
    );
  }
}

class CardGeneralPractitioners extends StatelessWidget {
  const CardGeneralPractitioners({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorApp.primaryColor,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              ImageAssets.get(ImageAssets.imgSampleDr),
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Imran Syahir',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Dokter Umum',
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            color: Color.fromARGB(204, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ))
              ],
            ),

            //! Line
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 1.0, //
              width: double.infinity, //
              color: const Color.fromARGB(80, 255, 255, 255), //
            ),

            //! Available Date Time
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! Date
                Row(
                  children: [
                    Image.asset(IconAssets.get(IconAssets.calendarCard)),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Sunday, 12 June',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ],
                ),
                //! Time
                const Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '11:00 - 12:00 AM',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello,',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Dimas Okva',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(
                    ImageAssets.get(ImageAssets.imgProfile),
                  ),
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
