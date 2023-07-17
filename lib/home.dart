import 'package:flutter/material.dart';
import 'package:network_test/data/api.dart';
import 'package:network_test/data/model.dart';

class MyClass extends StatefulWidget {
  const MyClass({super.key});

  @override
  State<MyClass> createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  late CatFact catFact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'NetWork test',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (catFact.imageUrl != null) buildImage(),
          Text(
            catFact.text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Divider(
              color: Colors.deepPurple,
            ),
          ),
          TextButton(
              onPressed: getData,
              style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 35)),
                  backgroundColor: MaterialStatePropertyAll(Colors.grey[100])),
              child: const Text(
                'Send request',
                style: TextStyle(fontSize: 20),
              )),
          const SizedBox(height: 40),
          const Text('Cache'),
          Switch(
              value: CatApi.isCached(),
              onChanged: (state) {
                CatApi.toggleCacheStatus();
                setState(() {});
              })
        ],
      )),
    );
  }

  ClipRRect buildImage() {
    var imageSize = MediaQuery.of(context).size.width * 0.7;

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Image.network(
        catFact.imageUrl!,
        width: imageSize,
        loadingBuilder:
            (BuildContext context, child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: Text('коша грузица...'));
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    catFact = CatFact('need to load fact', null);
  }

  Future getData() async {
    final newCatFact = await CatApi().getCatFacts();
    if (newCatFact != null) {
      setState(() {
        catFact = newCatFact;
      });
    }
  }
}
