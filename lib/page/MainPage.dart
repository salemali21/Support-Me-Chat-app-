import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../api/firebase_api.dart';
import '../model/firebase_file.dart';
import 'image_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<ListResult> futureFiles;
  late final storageRef = FirebaseStorage.instance.ref();

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('images').listAll();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("معرض الصور"),
      centerTitle: true,
    ),
     body:FutureBuilder<ListResult>(
       future: futureFiles,
       builder: (context,snapshot){
         if (snapshot.hasData){
           final files = snapshot.data!.items;
           return ListView.builder(
               itemCount: files.length,
               itemBuilder:(context, index) {
                 final file = files[index];

                 return ListTile(
                   title: Text(file.name),
                   leading: IconButton(
                     icon: const Icon(Icons.delete),
                     onPressed: () {
                       setState(() {
                         deleteFil(file);
                       });
                     },
                   ),
                   trailing: IconButton(
                       icon: const Icon(Icons.download),
                       onPressed: () => downloadFile(file)
                   ),
                 );
               }
           ) ;

         } else if (snapshot.hasError){
           return const Center(child: Text('Error handeling'),);
         } else {
           return const Center(child: CircularProgressIndicator(),);
         }
       },
     ),



    // FutureBuilder<List<FirebaseFile>>(
    //   future: futureFiles,
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.waiting:
    //         return Center(child: CircularProgressIndicator());
    //       default:
    //         if (snapshot.hasError) {
    //           return Center(child: Text('Some error occurred!'));
    //         } else {
    //           final files = snapshot.data!;
    //
    //           return Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               buildHeader(files.length),
    //               const SizedBox(height: 12),
    //               Expanded(
    //                 child: ListView.builder(
    //                   itemCount: files.length,
    //                   itemBuilder: (context, index) {
    //                     final file = files[index];
    //
    //                     return buildFile(context, file);
    //                   },
    //                 ),
    //               ),
    //             ],
    //           );
    //         }
    //     }
    //   },
    // ),
  );

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
    leading: ClipOval(
      child: Image.network(
        file.url,
        width: 52,
        height: 52,
        fit: BoxFit.cover,
      ),
    ),
    title: Text(
      file.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.blue,
      ),
    ),
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ImagePage(file: file),
    )),
  );
  //
  // Widget buildHeader(int length) => ListTile(
  //   tileColor: Colors.blue,
  //   leading: Container(
  //     width: 52,
  //     height: 52,
  //     child: Icon(
  //       Icons.file_copy,
  //       color: Colors.white,
  //     ),
  //   ),
  //   title: Text(
  //     '$length Files',
  //     style: TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 20,
  //       color: Colors.white,
  //     ),
  //   ),
  // );
  Future deleteFil (Reference ref)async{
    var desertRef = FirebaseStorage.instance.ref().child("images").child("/${ref.name}");

    //final desertRef = ref.child("files/amd");

// Delete the file
    await desertRef.delete();
    Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage())).then((_) {
      // This block runs when you have come back to the 1st Page from 2nd.
      setState(() {
        // Call setState to refresh the page.
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted ${ref.name}'),));
  }

  Future downloadFile (Reference ref) async {

    final url = await ref.getDownloadURL();

//final tempir = await getTemporaryDirectory();
//final path = '${tempir.path}/${ref.name}';
    final path = 'storage/emulated/0/Download/${ref.name}';

    final file = await Dio().download(url, path);

    print(path);
// final File newFile = await File(url).create();
// setState(() {
    // if (pickedFile != null) {
    //   _image = newImage;
    // } else {
    //   print('No image selected.');
    // }

    // final dir = await getApplicationDocumentsDirectory();
    // final file =File('${dir.path}/${ref.name}');
    // await ref.writeToFile(file);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded ${ref.name}'),));
  }
}