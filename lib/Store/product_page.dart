import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
 String QuantityOfBooks ="1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Book Store"),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,), onPressed: null),
        ],
      ),
      drawer: Drawer(),

      body: ListView(
        children: <Widget>[


         Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(top: 18.0, left: 18.0),
                   child: Text("Writer Name",style: TextStyle(
                       color: Colors.blue,
                       fontSize: 20.0,
                     fontWeight: FontWeight.bold
                   )),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top: 5.0, left: 18.0),
                   child: Text("Book Name of the author test",style: TextStyle(
                       color: Colors.blue,
                       fontSize: 15.0,
                       fontWeight: FontWeight.normal
                   )),
                 ),
               ],),


               Row(
                   //mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.only(left: 20.0),
                       child: Container(
                         decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),
                         alignment: Alignment.topLeft,
                         width: 40.0,
                         height: 40.0,
                         child: Center(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Text("50%",style: TextStyle(
                                   fontSize: 15.0,
                                   color: Colors.white,
                                   fontWeight: FontWeight.normal
                               ),),
                               Text("OFF",style: TextStyle(
                                   fontSize: 10.0,
                                   color: Colors.white,
                                   fontWeight: FontWeight.normal


                               ),)

                             ],
                                ),
                         ),
                       ),
                     ),
                     Center(
                       child: Image(
                         image: new AssetImage("images/circleasc.png"),width: 100.0,height: 100.0,
                       ),
                     ),
                   ],
               ),
               Padding(
                 padding: const EdgeInsets.only(top: 70.0, left: 20.0),
                 child: Row(
                   children: <Widget>[
                     Text("M.R.P.: ₹",style: TextStyle(
                     ),),
                     Text("150.0",style: TextStyle(
                       decoration: TextDecoration.lineThrough,
                     ),),
                   ],
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                 child: Row(
                   children: <Widget>[
                     Text("Price: ",style: TextStyle(
                     ),),
                     Text("₹",style: TextStyle(
                         color: Colors.red,
                         fontSize: 20.0
                     ),),
                     Text("75.0",style: TextStyle(
                       color: Colors.red,
                       fontSize: 20.0,
                       fontWeight: FontWeight.w400

                     ),),
                   ],
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                 child: Row(
                   children: <Widget>[
                     Text("You save: ",style: TextStyle(
                     ),),
                     Text("₹",style: TextStyle(
                         color: Colors.red,
                         fontSize: 20.0
                     ),),
                     Text("75.0",style: TextStyle(
                         color: Colors.red,
                         fontSize: 20.0,
                         fontWeight: FontWeight.w400

                     ),),
                   ],
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                 child: InkWell(
                   onTap: (){
                     showDialog(
                       context: context,
                       builder: (context)=> AlertDialog(
                         title: Text("Qty"),
                          content: Container(
                            height: 500.0,
                            width: 200.0,
                            child: ListView(
                                children: <Widget>[
                                  ListTile(title: Text("1"),
                                  onTap: (){
                                    setState(() {
                                      QuantityOfBooks = "1";
                                    });
                                    Navigator.pop(context);
                                  }
                                  ),
                                  ListTile(title: Text("2"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "2";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(title: Text("3"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "3";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(title: Text("4"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "4";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(title: Text("5"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "5";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(title: Text("6"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "6";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(title: Text("7"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "7";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),

                                  ListTile(title: Text("8"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "8";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(title: Text("9"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "9";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(title: Text("10"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "10";
                                        });
                                        Navigator.pop(context);
                                      }

                                  ),
                                  ListTile(title: Text("11"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "11";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(title: Text("12"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "12";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(title: Text("13"),
                                      onTap: (){
                                        setState(() {
                                          QuantityOfBooks = "13";
                                        });
                                        Navigator.pop(context);
                                      }
                                  ),

                                ],
                              ),
                          ),
                          ),
                     );
                   },
                   child: Container(
                     width: 105.0,
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.black87, width: 1.0),
                     gradient: LinearGradient(
                     colors: [Colors.grey.withOpacity(0.4), Colors.grey.withOpacity(0.8),],
                     begin: Alignment.topCenter,
                       end: Alignment.bottomCenter

                     )
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text("Quantity: ${QuantityOfBooks}",style: TextStyle(
                         ),),

                         Icon(Icons.arrow_drop_down),
                       ],
                     ),
                   ),
                 ),
               ),


               Padding(
                 padding: const EdgeInsets.only(top: 30.0),
                 child: Center(
                   child: InkWell(
                     child: Container(
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.deepOrange,width: 1.0),
                         gradient: LinearGradient(colors: [Colors.orangeAccent,Colors.deepOrange],
                         begin: Alignment.topCenter,
                           end: Alignment.bottomCenter
                         )
                       ),
                       width: MediaQuery.of(context).size.width-40.0,
                       height: 50.0,
                       child: Center(child: Text("Buy Now")),
                     ),
                   ),
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.only(top:8.0),
                 child: Center(
                   child: InkWell(
                     child: Container(
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.orange,width: 1.0),
                           gradient: LinearGradient(colors:
                           [Colors.orangeAccent.withOpacity(0.4),Colors.orange.withBlue(56)]
                           ,
                               begin: Alignment.topCenter,
                               end: Alignment.bottomCenter)
                       ),
                       width: MediaQuery.of(context).size.width-40.0,
                       height: 50.0,
                       child: Center(child: Text("Add to Cart")),
                     ),
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 20.0, top :20.0, bottom: 10.0),
                 child: Text("About this Item",style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 20.0

                 ),),
               ),
               Center(
                 child: Container(
                   width: MediaQuery.of(context).size.width-40.0,
                   decoration: BoxDecoration(
                       border: Border.all(color: Colors.black87,width: 1.0,style: BorderStyle.solid)
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.only(left: 10.0),
                         child: Text("Description",style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 15.0

                         ),),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 10.0),
                         child: Text("There are several things to consider in order to help your book achieve its greatest potential discoverability. Readers, librarians, and retailers can't purchase a book they can't find, and your book metadata is responsible for whether or not your book pops up when they type in search terms relevant to your book. Book metadata may sound complicated, but it consists of all the information that describes your book, including: your title, subtitle, series name, price, trim size, author name, book description, and more. There are two metadata fields for your book description: the long book description and the short book description. Although both play a role in driving traffic to your book, they have distinct differences.",style: TextStyle(
                             fontWeight: FontWeight.w500,
                             fontStyle: FontStyle.italic,
                             color: Colors.blueGrey

                         ),),
                       ),
                     ],
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(top: 10.0),
                 child: Center(
                   child: Container(
                     width: MediaQuery.of(context).size.width-40.0,
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.black87,width: 1.0,style: BorderStyle.solid)
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(left: 10.0),
                           child: Text("Features",style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 15.0
                           ),),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 30.0, right: 30.0,top: 20.0,bottom: 20.0),
                           child: Table(
                             border: TableBorder.all(width: 1.0,color: Colors.black87),
                             children: [
                               TableRow(
                                 children: [
                                   Container(
                                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                     height: 70.0,
                                     color: Colors.grey.withOpacity(0.7),
                                     child: Center(
                                       child: Text("Publisher "),
                                     ),
                                   ),
                                   Container(
                                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                     height: 70.0,
                                     color: Colors.grey.withOpacity(0.2),
                                     child: Center(
                                       child: Text("Publisher Name"),
                                     ),
                                   )
                                 ],
                               ),

                               TableRow(
                                 children: [
                                   Container(
                                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                     height: 70.0,
                                     color: Colors.grey.withOpacity(0.7),
                                     child: Center(
                                       child: Text("Publication Date"),
                                     ),
                                   ),
                                   Container(
                                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                     height: 70.0,
                                     color: Colors.grey.withOpacity(0.2),
                                     child: Center(
                                       child: Text("Publisher Name"),
                                     ),
                                   )
                                 ],
                               ),

                               TableRow(
                                   children: [
                                     Container(
                                       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                       height: 70.0,
                                       color: Colors.grey.withOpacity(0.7),
                                       child: Center(
                                         child: Text("Language"),
                                       ),
                                     ),
                                     Container(
                                       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                       height: 70.0,
                                       color: Colors.grey.withOpacity(0.2),
                                       child: Center(
                                         child: Text("English"),
                                       ),
                                     )
                                   ]
                               )
                             ],
                           )
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ],
           ),
        ),
      ]),
    );
  }
}



