import 'package:Roadlance_Police/Database/DbUpdater.dart';
import 'package:Roadlance_Police/Model/PolicePost.dart';
import 'package:Roadlance_Police/Screens/PoliceListView.dart';
import 'package:Roadlance_Police/Screens/PoliceMapView.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Components/DisplayBox.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import './Success.dart';

class PostDisplay extends StatefulWidget {
  PostDisplay({
    @required this.post,
  });

  final PolicePost post;

  @override
  _PostDisplayState createState() => _PostDisplayState();
}

class _PostDisplayState extends State<PostDisplay> {
  List<Widget> mediaUrls = [];
  VideoPlayerController controller;
  TextEditingController pointsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setMediaUrls();
  }

  void getApproveAmount() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Points Reward Amount'),
        content: TextField(
          controller: pointsController,
        ),
        actions: [
          FlatButton(
            onPressed: () {
              DbUpdater updater = DbUpdater();
              updater.approvePost(
                  widget.post, int.parse(pointsController.text));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoliceListView(),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Success(),
                ),
              );
            },
            child: Text(
              'Submit',
            ),
          )
        ],
      ),
    );
  }

  void setMediaUrls() async {
    int idx = 0;
    widget.post.mediaUrls.forEach(
      (url) {
        if (url != null) {
          setState(() {
            mediaUrls.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: widget.post.mediaDetails[idx]['mediaType'] == 'image'
                    ? SizedBox(
                        width: 350,
                        child: Image.network(
                          url,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                      )
                    : Text("Display video"),
              ),
            );
            idx += 1;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4b4266),
      appBar: AppBar(
        backgroundColor: Color(0xFF312c42),
        title: Text('Post'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_pin),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PoliceMapView(
                goto: LatLng(widget.post.latitude, widget.post.longitude),
              ),
            ),
          );
        },
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Violation : ',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    DisplayBox(
                      text: widget.post.violation,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: mediaUrls,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Email : ',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    DisplayBox(
                      text: widget.post.email,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Phone Number : ',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    DisplayBox(
                      text: widget.post.phoneNumber,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Description :    ',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    DisplayBox(
                      text: widget.post.description,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Number Plate : ',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    DisplayBox(
                      text: widget.post.numberPlate,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Location : ',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    DisplayBox(
                        text:
                            '(${widget.post.latitude.toStringAsFixed(2)}), (${widget.post.longitude.toStringAsFixed(2)})'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Upload Time : ',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    DisplayBox(text: '${widget.post.uploadTime}'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Status : ',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFF070c29),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                widget.post.status,
                                style: TextStyle(
                                  color: Color(0xFF50fa7b),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(
                                widget.post.status == 'Approved'
                                    ? Icons.check
                                    : Icons.error,
                                color: Color(0xFF50fa7b),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Color(0xFF50fa7b),
                    onPressed: () {
                      getApproveAmount();
                    },
                    icon: Icon(Icons.check),
                    label: Text('Approve'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Color(0xFFff5555),
                    onPressed: () {
                      DbUpdater updater = DbUpdater();
                      updater.declinePost(widget.post);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PoliceListView(),
                        ),
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Success()));
                    },
                    icon: Icon(Icons.error),
                    label: Text('Decline'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
