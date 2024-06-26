import 'package:flutter/material.dart';
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: const EdgeInsets.only(top: 60.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios,size: 30,)),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.favorite,color: Colors.red,size: 30,),
                        SizedBox(width: 13,),
                        Icon(Icons.share,size: 30,),
                        SizedBox(width: 13,),
                        Badge(
                          label: Text('1'),
                          child: Icon(Icons.shopping_bag_outlined,size: 30,),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Image(
                  height: 380,
                  width: 380,
                  image: AssetImage('assets/images/detail shirt.png')),
              const Row(
                children: [
                  Icon(Icons.on_device_training_sharp,color: Colors.grey,),
                  Text('Tokobaju.id',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Essentials Men's Short-Sleeve Crewneck T-Shirt",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,),),
              const SizedBox(
                height: 14,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.star,color: Colors.orange,),
                  Text('4.9 Ratings',style: TextStyle(
                    color: Colors.grey,fontWeight: FontWeight.bold
                      ,
                    fontSize: 15
                  ),),
                  Text('-',style: TextStyle(
                    fontSize: 30,
                  ),),
                  Text('2.3k+ Reviews ',style: TextStyle(
                      color: Colors.grey,fontWeight: FontWeight.bold
                      ,
                      fontSize: 15),),
          
                  Text('-',style: TextStyle(
                    fontSize: 30,
                  ),),
                  Text('2.9k+ Sold',style: TextStyle(
                      color: Colors.grey,fontWeight: FontWeight.bold
                      ,
                      fontSize: 15),),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text('About Items',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                      color: Color(0xff2A977D),
                  ),),
                  SizedBox(width: 20,),
                  Text('Reviews',style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0,right: 20),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Brand:',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),),
                        SizedBox(
                          width: 7,
                        ),
                        Text('ChAmkpR',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Color:',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Aprikot',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                    children: [
                      Column(
                        children: [
                          Text('Total Price'),
                          Text('\$18.00',style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2A977D),
                          ),),
                        ],
                      ),
                    ],
                  ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 70,
                          decoration: const BoxDecoration(
                            color: Color(0xff2A977D),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(7),
                              topLeft: Radius.circular(7),
                            )
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.shopping_basket_outlined,color: Colors.white,),
                                  Text('1',style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 120,
                          decoration:  const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(7),
                                topRight: Radius.circular(7),
                              )
                          ),
                          child:  const Center(
                            child: Text('Buy Now',style: TextStyle(
                              color: Colors.white,
                              fontSize: 17
                            ),),
                          ),
                        )
                      ],
                    ),
          
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
