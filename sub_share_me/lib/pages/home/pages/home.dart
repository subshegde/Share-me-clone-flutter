import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sub_share_me/constants/app_colors.dart';
import 'package:sub_share_me/pages/home/pages/singleSend.dart';

class Home extends StatefulWidget {
  final Map<String, List<AssetEntity>> grouped;
  const Home({Key? key, required this.grouped}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<AssetEntity> assets = [];
  Map<String, List<AssetEntity>> groupedAssets = {};

  late TabController _tabController;
  int index = 0;

  late TabController _tabControllerHistory;
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    groupedAssets = widget.grouped;

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    _tabControllerHistory = TabController(length: 2, vsync: this);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      safeSetState(() {
        index = _tabController.index;
      });
    }

    if (index == 0) {
    } else if (index == 1) {}
  }

  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(() {
        fn();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Share Me', style: TextStyle(color: AppColors.grey)),
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              _showMenu(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: AppColors.bg,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: TabBar(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  labelColor: AppColors.blue,
                  unselectedLabelColor: AppColors.grey,
                  indicatorColor: AppColors.blue,
                  indicatorWeight: 2,
                  indicatorPadding: const EdgeInsets.all(5),
                  labelPadding: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.only(left: 16),
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  tabs: const [
                    Tab(text: 'SHARE'),
                    Tab(text: 'HISTORY'),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildTab1(groupedAssets),
                  _buildTab2(context),
                ]),
          ),
        ],
      ),
    );
  }

Widget _buildTab2(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: TabBar(
                  controller: _tabControllerHistory,
                  onTap: (index) {
                    setState(() {
                      selectIndex = index;
                    });
                  },
                  labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                  indicatorColor: AppColors.blue,
                  tabs: [
                   Container(
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.bg,
                            ),
                            child:  Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Image.asset('assets/icons/received.png',color: AppColors.white,height: 20,width: 20,),
                                const SizedBox(width: 4,),
                                const Text(
                                'Received',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              ],)
                            ),
                   ),Container(
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.bg,
                            ),
                            child:  Center(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Image.asset('assets/icons/sent.png',color: AppColors.white,height: 20,width: 20,),
                                const SizedBox(width: 4,),
                                const Text(
                                'Sent',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              ],)
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabControllerHistory,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [ 
                      Image.asset('assets/icons/empty.png',scale: 2.2,),
                      const SizedBox(height: 10,),
                      const Text(
                      "Empty",
                      style: TextStyle(color: AppColors.white),
                    ),
                    ],)
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [ 
                      Image.asset('assets/icons/empty.png',scale: 2.2,),
                      const SizedBox(height: 10,),
                      const Text(
                      "Empty",
                      style: TextStyle(color: AppColors.white),
                    ),
                    ],)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}


Widget _buildTab1(Map<String, List<AssetEntity>> groupedAssets) {
  return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Container(
      height: 203,
      color: AppColors.containerGrey,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset('assets/icons/send.png', scale: 2.0),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Send',
                        style: TextStyle(
                            color: AppColors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset('assets/icons/receive.png', scale: 2.0),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Receive',
                        style: TextStyle(
                            color: AppColors.receive,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    const SizedBox(height: 10),
    Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: const Text(
                    'Recent',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            groupedAssets.isEmpty
                ? const Center(
                    child: Text('No assets found',
                        style: TextStyle(color: AppColors.grey)))
                : ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: groupedAssets.keys.map((date) {
                      List<AssetEntity> assetsForDate = groupedAssets[date]!;

                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 6, top: 5),
                              child: Text(
                                date,
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.grey),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.containerGrey,
                                border: Border.all(color: AppColors.containerGreyBorder,width: 1),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.0, right: 8.0, bottom: 2),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: AppColors.grey,
                                          size: 20.0,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "Images",
                                          style: TextStyle(
                                            color: AppColors.dimWhite,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:const NeverScrollableScrollPhysics(),
                                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                    ),
                                    itemCount: assetsForDate.length,
                                    itemBuilder: (context, index) {
                                      return FutureBuilder<File?>(
                                        future: assetsForDate[index].file,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            if (snapshot.hasData) {
                                              String imagePath = snapshot.data!.path;
                                              String imageName = snapshot.data!.uri.pathSegments.last;
                                              Future<DateTime>lastModifiedFuture = snapshot.data!.lastModified();

                                              return GestureDetector(
                                                onTap: () {
                                                  lastModifiedFuture.then((lastModifiedDate) {
                                                    String formattedDate = DateFormat('yyyy-MM-dd').format(lastModifiedDate);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FullScreenImage(
                                                          date: formattedDate,
                                                          file: File(imagePath),
                                                          fileName: imageName,
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(top: 3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:BorderRadius.circular(8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black.withOpacity(0.2),
                                                        blurRadius: 4.0,
                                                        spreadRadius: 1.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child:
                                                      FutureBuilder<Uint8List?>(
                                                    future: assetsForDate[index].thumbnailDataWithOption(
                                                      const ThumbnailOption(size: ThumbnailSize.square(200)),
                                                    ),
                                                    builder:(context, snapshot) {
                                                      if (snapshot.connectionState ==ConnectionState.done) {
                                                        if (snapshot.hasData) {
                                                          return ClipRRect(
                                                            borderRadius:BorderRadius.circular(0),
                                                            child: Image.memory(
                                                              snapshot.data!,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          );
                                                        } else {
                                                          return const Center(
                                                              child: Text('Error loading image', style: TextStyle(color: AppColors.grey)));
                                                        }
                                                      }
                                                      return const Center(
                                                          child:CircularProgressIndicator(color: AppColors.grey));
                                                    },
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                  child: Text('Error retrieving image file',style: TextStyle(color:AppColors.grey)));
                                            }
                                          }
                                          return const Center(
                                              child: CircularProgressIndicator(color: AppColors.grey));
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    ),
  ]);


}


void _showMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        color: AppColors.bg,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.desktop_windows, color: AppColors.blue),
              title: const Text('Share to PC',
                  style: TextStyle(color: AppColors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: AppColors.blue),
              title:
                  const Text('Webshare', style: TextStyle(color: AppColors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.blue),
              title: const Text('Personal info',
                  style: TextStyle(color: AppColors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_add, color: AppColors.blue),
              title:
                  const Text('Invite', style: TextStyle(color: AppColors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: AppColors.blue),
              title: const Text('About', style: TextStyle(color: AppColors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
}