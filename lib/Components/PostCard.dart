import 'package:Roadlance_Police/Model/PolicePost.dart';
import 'package:Roadlance_Police/Screens/PostDisplay.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  PostCard({
    @required this.post,
  });

  final PolicePost post;

  String getTime(String str) {
    if (str != null && str.length >= 7) {
      str = str.substring(0, str.length - 7);
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDisplay(
              post: post,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF151430),
            border: Border.all(
              color: Color(
                0XFFff79c6,
              ),
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Violation: ',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Flexible(
                      child: Text(
                        '${post.violation}',
                        style: TextStyle(
                          color: Color(0xFF50fa7b),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Description: ',
                      style: TextStyle(color: Colors.white),
                      softWrap: true,
                    ),
                    Flexible(
                      child: Text(
                        '${post.description}',
                        style: TextStyle(
                          color: Color(0xFF50fa7b),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Location: ', style: TextStyle(color: Colors.white)),
                    Text(
                      '(${post.longitude}), (${post.latitude})',
                      style: TextStyle(
                        color: Color(0xFF50fa7b),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Upload Time: ',
                        style: TextStyle(color: Colors.white)),
                    Text(
                      '${getTime(post.uploadTime)}',
                      style: TextStyle(
                        color: Color(0xFF50fa7b),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Number Plate: ',
                        style: TextStyle(color: Colors.white)),
                    Text(
                      '${post.numberPlate}',
                      style: TextStyle(
                        color: Color(0xFF50fa7b),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
