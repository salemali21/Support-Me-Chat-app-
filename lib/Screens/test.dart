import 'dart:io';


import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class TEst extends StatefulWidget {
  const TEst({Key? key}) : super(key: key);

  @override
  State<TEst> createState() => _TEstState();
}

class _TEstState extends State<TEst> {
late Future<ListResult> futureFiles;
late final storageRef = FirebaseStorage.instance.ref();


void initState(){
  super.initState();
  futureFiles = FirebaseStorage.instance.ref('/files').listAll();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestUpload'),
      ),
      body: FutureBuilder<ListResult>(
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
    );
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
Future deleteFil (Reference ref)async{
 var desertRef = FirebaseStorage.instance.ref().child("files").child("/${ref.name}");

  //final desertRef = ref.child("files/amd");

// Delete the file
  await desertRef.delete();
  Navigator.push(context, MaterialPageRoute(builder: (_) => TEst())).then((_) {
    // This block runs when you have come back to the 1st Page from 2nd.
    setState(() {
      // Call setState to refresh the page.
    });
  });
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted ${ref.name}'),));
}
}



