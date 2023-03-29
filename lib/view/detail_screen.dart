import 'package:flutter/material.dart';
import 'package:nuemtech_test/model/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  final Datum? data;
  const DetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(246,248,248,253,),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: _height,
            width: _width,
            child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(16),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color.fromARGB(255, 49,38,81,),),

                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white),
                        ))
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 4,color:Color.fromARGB(255, 49,38,81,), ),
                            borderRadius: BorderRadius.circular(100),
                      ),
                      padding: EdgeInsets.all(4),
                      child: CircleAvatar(
                        radius: 56,
                        backgroundImage: NetworkImage(widget.data!.picture),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.data!.firstName+" ",style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color:  Color.fromARGB(255, 49,38,81,),
                        ),),
                        Text(widget.data!.lastName,style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color:  Color.fromARGB(255, 49,38,81,),
                        ),)
                      ],
                    ),
                    Text(widget.data!.id,style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:  Color.fromARGB(255, 49,38,81,),
                    ),),
                    SizedBox(
                      height: _height/20,
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Color.fromARGB(255, 49,38,81,),
                      endIndent: 20,
                      indent: 20,
                    ),
                    Container(
                      height: _height/3,
                      width: _width - 50,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          DetailTile(title: 'ID',val: widget.data!.id.toString()),
                          DetailTile(title: 'Name Title',val: widget.data!.title.name.toString()),
                          DetailTile(title: 'First name',val: widget.data!.firstName.toString()),
                          DetailTile(title: 'Last name',val: widget.data!.lastName.toString()),
                        ],
                      ),
                    )
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
class DetailTile extends StatelessWidget {
  final String ? title;
  final String ? val;
  const DetailTile({Key? key, this.title, this.val}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title!+" :",style: GoogleFonts.lexend(
                fontSize: 14
              ),),
              Text(val!,style: GoogleFonts.lexend(
                  fontSize: 14,
                color: Color.fromARGB(255, 49,38,81,),
              ),),
            ],
          ),
        ),
      ],
    );
  }
}

