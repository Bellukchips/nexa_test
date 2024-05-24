import 'package:flutter/material.dart';

import 'package:nexa_test/models/doctor/doctor_model.dart';
import 'package:nexa_test/models/tab_bar_schedule/model_tab_bar_schedule.dart';
import 'package:nexa_test/pages/widgets/item_tabBar_schedule.dart';
import 'package:nexa_test/services/doctor_service.dart';
import 'package:nexa_test/shared/assets.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int selectedIndex = 1;

  late Future<List<DoctorModel>> _doctorListFuture;

  @override
  void initState() {
    _fetchDoctorList();
    super.initState();
  }

  Future<void> _fetchDoctorList() async {
    try {
      _doctorListFuture = DoctorService.getAllDoctor();
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 50,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final model = menuTabBarSchedule[index];
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 0 : 5),
                      child: ItemTabBarSchedule(
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          model: model,
                          fontSize: 14),
                    );
                  },
                  itemCount: menuTabBarSchedule.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<List<DoctorModel>>(
                  future: _doctorListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError || snapshot.data == null) {
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
                          height: 215 * doctorList.length + 200,
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
                                child: CardScheduleDoctor(model: doctor),
                              );
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardScheduleDoctor extends StatelessWidget {
  final DoctorModel model;
  const CardScheduleDoctor({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! Reviews
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: Color(0xff8696BB),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.tanggal,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff8696BB),
                      ),
                    )
                  ],
                ),
                //! Open at
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: Color(0xff8696BB),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.jadwal,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff8696BB),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 50,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                  color: const Color(0xff63B4FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100)),
              child: const Text(
                "Detail",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }
}
