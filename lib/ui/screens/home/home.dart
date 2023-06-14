import 'package:cs_task1/ui/screens/custombutton.dart';
import 'package:cs_task1/utils/constants/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? userProfile;

  const HomeScreen({Key? key, this.userProfile}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> posts = [];
  bool showAllPosts = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response =
          await Dio().get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        setState(() {
          posts = response.data;
        });
      } else {
        print('Failed to fetch posts');
      }
    } catch (error) {
      print('Failed to fetch posts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userProfile != null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.i.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // TODO: Implement hamburger button functionality
            },
          ),
          title: const Text('Lorem Ipsum'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO: Implement search button functionality
              },
            ),
          ],
        ),
        body: initialLayout(context),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Widget initialLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomButton(
              title: 'ALL POSTS',
              isSelected: showAllPosts,
              onTap: () {
                setState(() {
                  showAllPosts = true;
                });
              },
            ),
            CustomButton(
              title: 'PROFILE',
              isSelected: !showAllPosts,
              onTap: () {
                setState(() {
                  showAllPosts = false;
                });
              },
            ),
          ],
        ),
        if (showAllPosts)
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final bool isUserPost =
                    post['userId'] == widget.userProfile!['id'];
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: ListTile(
                    title: Text(
                      post['title'],
                      style: TextStyle(
                        fontWeight:
                            isUserPost ? FontWeight.bold : FontWeight.normal,
                        color: isUserPost
                            ? AppColors.i.primaryColor
                            : Colors.black,
                      ),
                    ),
                    subtitle: Text(post['body']),
                  ),
                );
              },
            ),
          ),
        if (!showAllPosts && widget.userProfile != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(4, (index) {
                String title;
                String content;
                switch (index) {
                  case 0:
                    title = 'Name';
                    content = widget.userProfile!['name'];
                    break;
                  case 1:
                    title = 'Username';
                    content = widget.userProfile!['username'];
                    break;
                  case 2:
                    title = 'Address';
                    content =
                        '${widget.userProfile!['address']['street']}, ${widget.userProfile!['address']['suite']}, ${widget.userProfile!['address']['city']}';
                    break;
                  case 3:
                    title = 'Zipcode';
                    content = widget.userProfile!['address']['zipcode'];
                    break;
                  default:
                    title = '';
                    content = '';
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                content,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ],
                );
              }),
            ),
          ),
      ],
    );
  }
}
