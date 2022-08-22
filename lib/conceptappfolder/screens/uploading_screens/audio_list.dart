import 'dart:developer';

import 'package:concept/screens/uploading_screens/audio_editor.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({Key? key}) : super(key: key);

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();


  playSong(String? uri){
   try{
     _audioPlayer.setAudioSource(
         AudioSource.uri(
             Uri.parse(uri!)
         )
     );
     _audioPlayer.play();
   } on Exception {
     log("Error");
   }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _audioPlayer.dispose();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  void requestPermission(){
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
        onPressed: (){
          Navigator.pop(context);
        },
        ),
        title: Text("Audios", style: TextStyle(
          color: Colors.black,
        ),),
        // actions: [
        //   IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black,),),
        // ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item){
          if(item.data == null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(item.data!.isEmpty){
            return Center(child: Text("No Songs Found"));
          }
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(item.data![index].displayNameWOExt),
              subtitle: Text("${item.data![index].artist}"),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading:  const CircleAvatar(
                  child: Icon(
                      Icons.music_note,
                  ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AudioEditor(
                  songModel: item.data![index],
                  audioPlayer: _audioPlayer,
                )));
              },
            ),
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
