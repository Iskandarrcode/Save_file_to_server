import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson88_upload_download/blocs/export_blocs.dart';
import 'package:lesson88_upload_download/ui/widgets/book_widget.dart';
import 'package:lesson88_upload_download/ui/widgets/carousel_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                  text: "Book ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
              TextSpan(
                text: "Junction",
                style: TextStyle(
                  color: Color(0xffD1618A),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ZoomTapAnimation(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset("assets/icons/notification.png"),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<FileBloc, FileState>(
        bloc: context.read<FileBloc>()..add(GetFiles()),
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(state.errorMessage!),
            );
          }

          if (state.files == null || state.files!.isEmpty) {
            return const Center(
              child: Text("Fayllar mavjud emas"),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                    prefixIcon:
                        Icon(Icons.search_sharp, color: Colors.grey.shade600),
                    hintText: "Search book",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
              const RowsWidget(),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Continue Reading",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const CarouselWidget(),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Best Sellers",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              const SizedBox(height: 13),
            ],
          );
        },
      ),
    );
  }
}
