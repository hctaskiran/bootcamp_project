
// class MainBottomAppBar extends StatelessWidget {
//   const MainBottomAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       color: const Color.fromARGB(255, 244, 206, 219),
//       child: SizedBox(
//         height: 60,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                   icon: const Icon(Icons.restaurant_rounded),
//                   onPressed: () {
//                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RestaurantView()));
//                   }),
//               IconButton(
//                 icon: const Icon(Icons.local_movies_outlined),
//                 onPressed: () {
//                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CinemaView()));
//                 },
//               ),
//               IconButton(
//                 icon: const Icon(Icons.local_cafe_rounded),
//                 onPressed: () {
//                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CafeView()));
//                 },
//               ),
//               IconButton(
//                 icon: const Icon(Icons.settings),
//                 onPressed: () {
//                   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OtherPage()));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }