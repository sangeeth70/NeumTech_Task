import 'package:flutter/material.dart';
import 'package:nuemtech_test/Services.dart';
import 'package:nuemtech_test/model/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuemtech_test/view/detail_screen.dart';
class User_list extends StatefulWidget {
  const User_list({Key? key}) : super(key: key);

  @override
  State<User_list> createState() => _User_listState();
}

class _User_listState extends State<User_list> {
  @override
  void initState() {
    api.getusers();
    // TODO: implement initState
    super.initState();
  }

  TextEditingController searchtext = TextEditingController();
  List<Datum> searchList = [];
  bool searchbool = false;

  search() {
    searchList.clear();
    if (api.userdata == null) {
    } else {
      if (searchtext.text == null) {
        setState(() {
          searchbool = false;
        });
      } else {
        setState(() {
          searchbool = true;
        });
        api.userdata!.data.forEach((element) {
          if (element.lastName
              .toLowerCase()
              .contains(searchtext.text.toLowerCase())) {
            searchList.add(element);
            print(element.lastName);
          }
        });
        searchList.sort(
          (a, b) => a.lastName.compareTo(b.lastName),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(246,248,248,253,),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: _height/5,
              width: _width,
              child: Column(
                children: [
                  SizedBox(
                    height: _height/14,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: _width/14,
                      ),
                      Text("NEUMTECH",style: GoogleFonts.lexend(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 49,38,81,),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: _width/14,
                      ),
                      Text("Staff list",style: GoogleFonts.lexend(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 49,38,81,),
                      )),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: _height/14,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 49,38,81,),
                borderRadius: BorderRadius.circular(18)
              ),
              padding: const EdgeInsets.all(10),
              child: TextField(
                cursorColor: Colors.white,
                style: GoogleFonts.lexend(
                    fontSize: 16,
                    color: Colors.white
                ),
                controller: searchtext,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.search_sharp,color: Colors.white),
                  fillColor: Colors.yellow,
                  border: InputBorder.none,
                     hintStyle: GoogleFonts.lexend(
                         fontSize: 16,
                       color: Colors.white
                     ),
                     hintText: ' search'),
                onChanged: (value) {
                  if(value == null){
                    setState(() {
                      searchbool = false;
                    });
                  }else {
                    search();
                  }
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: api.getusers(),
                builder: (context, AsyncSnapshot<List<Datum>> snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 49,38,81,),
                  ))
                      : searchbool == true
                          ? ListView.builder(
                              itemCount: searchList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(data: searchList[index],)));

                                  },
                                  child: MyTile(
                                      name: searchList[index].lastName,
                                      img: searchList[index].picture,
                                      title: ''
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                print(snapshot.data?[index].id);
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(data: snapshot.data?[index],)));
                                  },
                                  child: MyTile(
                                    name: snapshot.data?[index].lastName ?? '',
                                    img: snapshot.data?[index].picture ?? '',
                                    title: snapshot.data![index].title.name.toString(),
                                  ),
                                );
                              },
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTile extends StatelessWidget {
  final String? name;
  final String? img;
  final String? title;
  const MyTile({Key? key, required this.name, required this.img, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: _width / 20, right: _width / 20,bottom: 16),
      height: 100,
      width: _width - 120,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          SizedBox(
            width: _width/30,
          ),
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(img!),
          ),
          SizedBox(
            width: _width/30,
          ),
          Text(title!+" "+name!,style: GoogleFonts.lexend(
            fontSize: 18,
          )),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Icon(Icons.arrow_forward_ios_rounded),
          )
        ],
      ),
    );
  }
}
