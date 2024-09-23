import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/screens/experimentsList.dart';
import 'package:apt3065/src/screens/home_page.dart';
import 'package:apt3065/src/utils/consumers_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class TopicsListPage extends ConsumerWidget {
  const TopicsListPage({Key? key, required this.subjectName}) : super(key: key);
  final String subjectName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ValueNotifier userCredential = ValueNotifier('');
    late List<String> SP_SubjectNames = [];

    late List<String> SP_TopicNames = [];

    return Scaffold(
      body: SingleChildScrollView(
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
                                padding: const EdgeInsets.only(
                                    left: 20, top: 50, bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CachedNetworkImage(
                                      alignment: Alignment.topLeft,
                                      imageUrl: currentUserData['imageLink'],
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        radius: 30,
                                        backgroundImage: imageProvider,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 15),
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
                                      margin: const EdgeInsets.only(right: 20),
                                      // color: Colors.amber,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Iconsax.notification,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(
                                top: 35,
                              )),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                              color: Color.fromARGB(
                                                  255, 230, 230, 230)))),
                                  child: const Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20)),
                                      Icon(
                                        Iconsax.search_normal,
                                        color:
                                            Color.fromARGB(255, 155, 155, 155),
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
                              const Padding(padding: EdgeInsets.only(top: 40)),
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(35),
                                        topRight: Radius.circular(35)),
                                    color: GeneralAppColors.whiteColor),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    AsyncValue<List<Map<String, dynamic>>>
                                        homepagesubjectData = ref.watch(
                                            TopicsFinderProvider(subjectName));
                                    return homepagesubjectData.when(
                                        data: (subjectData) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0, left: 27),
                                                  child: Text(
                                                    'Topics for $subjectName',
                                                    style: const TextStyle(
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
                                                    width: width,
                                                    child: Center(
                                                      child: Wrap(
                                                        children: List.generate(
                                                            subjectData.length,
                                                            (index) {
                                                          String topicName =
                                                              subjectData[index]
                                                                  .keys
                                                                  .first;
                                                          SP_TopicNames.add(
                                                              topicName);

                                                          String subjectImage =
                                                              subjectData[index]
                                                                      .values
                                                                      .first[
                                                                  'topicImage'];
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 15,
                                                                    top: 20),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            BiologyExperimentsList(
                                                                              topicName: topicName,
                                                                            )));
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
                                                                        ),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              subjectImage,
                                                                          height:
                                                                              150,
                                                                          placeholder: (context, url) =>
                                                                              const CircularProgressIndicator(),
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
                                                                          topicName,
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
                                                      ),
                                                    )),
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
            ),
          ],
        ),
      ),
    );
  }
}
