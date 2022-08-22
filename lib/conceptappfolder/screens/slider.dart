import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:video_player/video_player.dart';

class Slideppt extends StatefulWidget {
  const Slideppt({ Key? key }) : super(key: key);

  @override
  State<Slideppt> createState() => _SlidepptState();
}

class _SlidepptState extends State<Slideppt>{


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TikTokStyleFullPageScroller(
        contentSize: 20,
        swipeVelocityThreshold: 2000,
        animationDuration: const Duration(milliseconds: 300),
        builder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueGrey,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 400,
                    width: 400,
                    color: Colors.red,

                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.lightGreen,
                        radius: 27,
                      ),
                      SizedBox(width: 10,),
                      const Text("UserName",style: TextStyle(fontSize: 18,color: Colors.white),),
                      SizedBox(width: 10,),
                      ElevatedButton(onPressed: (){}, child: Text("Follow",style: TextStyle(fontSize: 15),))
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Column(
                    children: const [
                      Icon(Icons.favorite,size: 37,color: Colors.white,),
                      SizedBox(height: 10,),
                      Icon(Icons.comment,size: 37,color: Colors.white,),
                      SizedBox(height: 10,),
                      Icon(Icons.share,size: 37,color: Colors.white,),
                      SizedBox(height: 10,),
                      Icon(Icons.more_horiz,size: 37,color: Colors.white,),
                    ],
                  ),
                )


              ],

            ),
          );
        },
      ),
    );
  }



}
