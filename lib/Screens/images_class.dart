// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:rec_chat/Services/storage_services.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
// class ImageUpload extends StatefulWidget {
//   const ImageUpload({Key? key}) : super(key: key);
//
//   @override
//   State<ImageUpload> createState() => _ImageUploadState();
// }
//
// class _ImageUploadState extends State<ImageUpload> {
//   @override
//   Widget build(BuildContext context) {
//     final Storage storage = Storage();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('images upload'),
//       ),
//       body: Column(
//           children: [
//       Center(
//       child: ElevatedButton(
//       onPressed: () async {
//     final results = await FilePicker.platform.pickFiles(
//     allowMultiple: true,
//     type: FileType.custom,
//     allowedExtensions: ['png', 'jpg', 'mp4']);
//     if (results == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(
//     content: Text('No file selected'),
//     ),
//     );
//     }
//     final path = results!.files.single.path;
//     final fileName = results.files.single.name;
//
//     storage
//         .uploadFile(path!, fileName)
//         .then((value) => print('done'));
//     },
//       child: Text('upload file'),
//     ),
//     ),
//     FutureBuilder(
//     future: storage.listFiles(),
//     builder: (BuildContext context,
//     AsyncSnapshot<firebase_storage.ListResult> snapshot) {
//     if (snapshot.connectionState == ConnectionState.done &&
//     snapshot.hasData) {
//     return Container(
//     padding: EdgeInsets.symmetric(horizontal: 20),
//     height: 50,
//     child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     shrinkWrap: true,
//     itemCount: snapshot.data!.items.length,
//     itemBuilder: (BuildContext context, int index) {
//     return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: ElevatedButton(
//     onPressed: () {},
//     child: Text(snapshot.data!.items[index].name),
//     ),
//     );
//     }),
//     );
//     }
//     if (snapshot.connectionState == ConnectionState.waiting ||
//     !snapshot.hasData) {
//     return CircularProgressIndicator();
//     }
//     return Container();
//     },),
//     Expanded(
//       child: FutureBuilder(
//       future: storage.downloadURL('IMG_20211221_204322.jpg'),
//       builder: (BuildContext context,
//       AsyncSnapshot<String> snapshot) {
//       if (snapshot.connectionState == ConnectionState.done &&
//       snapshot.hasData) {
//         return Container(
//           width: 500, height: 800,
//           child: Image.network(
//             snapshot.data!,
//             fit: BoxFit.cover,
//           ),);
//       }
//       if (snapshot.connectionState == ConnectionState.waiting ||
//       !snapshot.hasData) {
//       return CircularProgressIndicator();
//       }
//       return Container();
//       },),
//     )
//     ],
//     ),
//     );
//     }
//   }
