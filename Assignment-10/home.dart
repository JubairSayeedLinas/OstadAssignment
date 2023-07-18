import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return LayoutBuilder(builder: (context, constraints){
         if (constraints.maxWidth < constraints.maxHeight) {
           return Column(
             children: [
               Expanded(
                   child:CircleAvatar(
           radius: MediaQuery.of(context).size.width / 2,
         backgroundImage: NetworkImage('https://images.pexels.com/photos/16122334/pexels-photo-16122334/free-photo-of-man-standing-on-a-deck-near-a-bridge-with-the-view-of-istanbul-across-the-bosphorus-strait.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                   )

               ),
               Center(
                 child: Text(
                   'John Doe',
                   style: TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.bold,

                   ),
                   textAlign: TextAlign.center,
                 ),
               ),
               SizedBox(height: 8), // Add spacing between title and paragraph
               Text(
                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                 style: TextStyle(fontSize: 16),

               ),

               Expanded(
                   child: GridView.count(
                       crossAxisCount: 3,
                     crossAxisSpacing: 10,

                     children: List.generate(6, (index) =>
                     Image.network('https://images.pexels.com/photos/11816677/pexels-photo-11816677.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')
                     ),

                   ))
             ],
           );


         }
         else
           return Row(
             children: [
               Expanded(
                 //flex: 1,
                   child:CircleAvatar(
                     radius: MediaQuery.of(context).size.width / 4,
                     backgroundImage: NetworkImage('https://images.pexels.com/photos/16122334/pexels-photo-16122334/free-photo-of-man-standing-on-a-deck-near-a-bridge-with-the-view-of-istanbul-across-the-bosphorus-strait.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                   )

               ),
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Center(
                         child: Text(
                           'John Doe',
                           style: TextStyle(
                             fontSize: 24,
                             fontWeight: FontWeight.bold,

                           ),
      
                         ),
                       ),
                       SizedBox(height: 8), 
                       Text(
                         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                         style: TextStyle(fontSize: 16),

                       ),
                       Expanded(
                         child: GridView.count(
                           crossAxisCount: 3,
                           crossAxisSpacing: 10,

                           children: List.generate(6, (index) =>
                               Image.network('https://images.pexels.com/photos/11816677/pexels-photo-11816677.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')
                           ),

                         ),
                       )
                     ],
                   ),
                 ),
               ),
            /
               
             ],

           );
       });
  }
  }

