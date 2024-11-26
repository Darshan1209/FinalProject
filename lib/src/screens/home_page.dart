import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/screens/UserListPage.dart';
import 'package:apt3065/src/screens/chat_page.dart';
import 'package:apt3065/src/screens/experimentsList.dart';
import 'package:apt3065/src/screens/messagingPage.dart';
import 'package:apt3065/src/screens/topicsListPage.dart';
import 'package:apt3065/src/utils/consumers_helper.dart';
import 'package:apt3065/src/widgets/chatbutton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ValueNotifier userCredential = ValueNotifier('');
    late List<String> SP_SubjectNames = [];
    late List<String> SP_TopicNames = [];
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 211, 212, 240),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  AsyncValue homepagefinalData =
                      ref.watch(CurrentUserDataProvider);
                  return homepagefinalData.when(
                      data: (currentUserData) => Container(
                            color: const Color(0xFFDCE4FA),
                            child: Column(
                              children: [
                                Container(
                                  // color: Color(0xFFDCE4FA),
                                  width: width,
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CachedNetworkImage(
                                        alignment: Alignment.topLeft,
                                        imageUrl:
                                            currentUserData['imageLink'] != null
                                                ? currentUserData['imageLink']
                                                : 'assets/images/profile.png',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                CircleAvatar(
                                          radius: 30,
                                          backgroundImage: imageProvider,
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentUserData['name'],
                                              style: const TextStyle(
                                                  fontFamily: "QuickSand",
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: -0.5),
                                            ),
                                            Text(
                                              // textAlign: TextAlign.left,
                                              currentUserData['eduLevel'],

                                              style: const TextStyle(
                                                  fontFamily: "QuickSand",
                                                  fontSize: 17,
                                                  color: Color.fromARGB(
                                                      255, 136, 136, 136),
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: -0.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        // color: Colors.amber,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserListPage()));
                                          },
                                          icon: const Icon(
                                            Iconsax.message,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 35)),
                                GestureDetector(
                                  onTap: () {
                                    showSearch(
                                      context: context,
                                      delegate: CustomSearchDelegate(
                                          SP_SubjectNames, SP_TopicNames),
                                    );
                                  },
                                  child: Container(
                                    width: width * 0.88,
                                    height: 54,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: GeneralAppColors.whiteColor,
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 230, 230, 230)),
                                            top: BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 230, 230, 230)),
                                            left: BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 230, 230, 230)),
                                            right: BorderSide(
                                                width: 1.5,
                                                color:
                                                    Color.fromARGB(255, 230, 230, 230)))),
                                    child: const Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 20)),
                                        Icon(
                                          Iconsax.search_normal,
                                          color: Color.fromARGB(
                                              255, 155, 155, 155),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 15)),
                                        Text(
                                          'Search for courses',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 155, 155, 155),
                                              fontSize: 18,
                                              fontFamily: 'QuickSand',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.5),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 40)),
                                Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(35),
                                          topRight: Radius.circular(35)),
                                      color: GeneralAppColors.whiteColor),
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      AsyncValue homepagesubjectData =
                                          ref.watch(HomePageSubjectsProvider);
                                      return homepagesubjectData.when(
                                          data: (subjectData) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20.0, left: 27),
                                                    child: Text(
                                                      'Subjects',
                                                      style: TextStyle(
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'QuickSand',
                                                        letterSpacing: -0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8)),
                                                  Container(
                                                      height: 200,
                                                      child: ListView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: List.generate(
                                                            subjectData.length,
                                                            (index) {
                                                          String subjectName =
                                                              subjectData[index]
                                                                  .keys
                                                                  .first;
                                                          SP_SubjectNames.add(
                                                              subjectName);

                                                          Color
                                                              subjectCardColor;
                                                          if (subjectName ==
                                                              'Biology') {
                                                            subjectCardColor =
                                                                GeneralAppColors
                                                                    .biologyColor;
                                                          } else if (subjectName ==
                                                              'Chemistry') {
                                                            subjectCardColor =
                                                                GeneralAppColors
                                                                    .chemistryColor;
                                                          } else if (subjectName ==
                                                              'Physics') {
                                                            subjectCardColor =
                                                                GeneralAppColors
                                                                    .physicsColor;
                                                          } else {
                                                            subjectCardColor =
                                                                GeneralAppColors
                                                                    .whiteColor;
                                                          }
                                                          String subjectImage =
                                                              subjectData[index]
                                                                      [
                                                                      subjectName]
                                                                  [
                                                                  'subjectImage'];
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: index ==
                                                                            0
                                                                        ? 20
                                                                        : 7),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                TopicsListPage(subjectName: subjectName)));
                                                              },
                                                              child: Card(
                                                                color: GeneralAppColors
                                                                    .whiteColor,
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.3),
                                                                        spreadRadius:
                                                                            2,
                                                                        blurRadius:
                                                                            8,
                                                                        offset: const Offset(
                                                                            3,
                                                                            4), // changes position of shadow
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                  width: 150,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          color:
                                                                              subjectCardColor,
                                                                        ),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              subjectImage,
                                                                          height:
                                                                              150,
                                                                          placeholder: (context, url) =>
                                                                              Container(
                                                                            color:
                                                                                Colors.grey[300],
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              const Icon(Icons.error),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              8),
                                                                      Container(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10),
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          subjectName,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      )),
                                                  Consumer(
                                                    builder:
                                                        (context, ref, child) {
                                                      AsyncValue
                                                          trendingTopicsData =
                                                          ref.watch(
                                                              TrendingTopicsProvider);
                                                      return trendingTopicsData
                                                          .when(
                                                              data:
                                                                  (topicsData) =>
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: 40, left: 27),
                                                                            child:
                                                                                Text(
                                                                              'Topics',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 23,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontFamily: 'QuickSand',
                                                                                letterSpacing: -0.5,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Padding(
                                                                              padding: EdgeInsets.only(top: 8)),
                                                                          Container(
                                                                              height: 210,
                                                                              child: ListView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                children: List.generate(topicsData.length, (index) {
                                                                                  String topicName = topicsData[index].keys.first;
                                                                                  Color subjectCardColor;
                                                                                  SP_TopicNames.add(topicName);
                                                                                  // if (subjectName == 'Biology') {
                                                                                  //   subjectCardColor = GeneralAppColors.biologyColor;
                                                                                  // } else if (subjectName == 'Chemistry') {
                                                                                  //   subjectCardColor = GeneralAppColors.chemistryColor;
                                                                                  // } else if (subjectName == 'Physics') {
                                                                                  //   subjectCardColor = GeneralAppColors.physicsColor;
                                                                                  // } else {
                                                                                  //   subjectCardColor = GeneralAppColors.whiteColor;
                                                                                  // }
                                                                                  String topicImage = topicsData[index][topicName]['topicImage'];
                                                                                  return Padding(
                                                                                    padding: EdgeInsets.only(left: index == 0 ? 20 : 7),
                                                                                    child: Card(
                                                                                      color: GeneralAppColors.whiteColor,
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey.withOpacity(0.3),
                                                                                              spreadRadius: 2,
                                                                                              blurRadius: 8,
                                                                                              offset: const Offset(3, 4), // changes position of shadow
                                                                                            ),
                                                                                          ],
                                                                                          color: Colors.white,
                                                                                          borderRadius: BorderRadius.circular(12),
                                                                                        ),
                                                                                        width: 150,
                                                                                        child: GestureDetector(
                                                                                          onTap: () {
                                                                                            Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(
                                                                                                    builder: (context) => BiologyExperimentsList(
                                                                                                          topicName: topicName,
                                                                                                        )));
                                                                                          },
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                                  // color: subjectCardColor,
                                                                                                ),
                                                                                                child: CachedNetworkImage(
                                                                                                  fit: BoxFit.cover,
                                                                                                  imageUrl: topicImage,
                                                                                                  height: 150,
                                                                                                  placeholder: (context, url) => Container(
                                                                                                    color: Colors.grey[300],
                                                                                                  ),
                                                                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(height: 8),
                                                                                              Container(
                                                                                                padding: const EdgeInsets.only(left: 10),
                                                                                                alignment: Alignment.centerLeft,
                                                                                                child: Column(
                                                                                                  children: [
                                                                                                    // Padding(
                                                                                                    //   padding: const EdgeInsets.only(left: 0.0),
                                                                                                    //   child: Text(
                                                                                                    //     subjectName,
                                                                                                    //     style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
                                                                                                    //   ),
                                                                                                    // ),
                                                                                                    Text(
                                                                                                      topicName,
                                                                                                      style: const TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }),
                                                                              )),
                                                                        ],
                                                                      ),
                                                              error: (error,
                                                                      stack) =>
                                                                  Text(
                                                                      'Error: $error'),
                                                              loading: () =>
                                                                  const Text(
                                                                      'Loading...'));
                                                    },
                                                  ),
                                                ],
                                              ),
                                          error: (error, stack) =>
                                              Text('Error: $error'),
                                          loading: () =>
                                              const Text('Loading...'));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                      error: (error, stack) => Text('Error: $error'),
                      loading: () => const Text('Loading...'));
                },
                child: Container(
                  width: width,
                  color: GeneralAppColors.blackColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> subjectNames;
  final List<String> topicNames;
  List<String> searchTerms = [];

  CustomSearchDelegate(this.subjectNames, this.topicNames) {
    searchTerms.addAll(subjectNames);
    searchTerms.addAll(topicNames);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Passing an empty string instead of null
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchquery = [];
    List<String> subjects = ['Biology', 'Chemistry', 'Physics'];
    for (var name in searchTerms) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (BuildContext context, int index) {
        var result = matchquery[index];
        return GestureDetector(
          onTap: () {
            !subjects.contains(result)
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BiologyExperimentsList(
                              topicName: result,
                            )))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TopicsListPage(subjectName: result)));
            ;
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchquery = [];
    List<String> subjects = ['Biology', 'Chemistry', 'Physics'];

    for (var name in searchTerms) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (BuildContext context, int index) {
        var result = matchquery[index];
        return GestureDetector(
          onTap: () {
            !subjects.contains(result)
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BiologyExperimentsList(
                              topicName: result,
                            )))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TopicsListPage(subjectName: result)));
            ;
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }
}
