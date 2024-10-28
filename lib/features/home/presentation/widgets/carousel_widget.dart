import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/carousel_slide_bloc/carousel_slide_bloc_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/carousel_slide_bloc/carousel_slide_bloc_event.dart';
import 'package:serve_mate/features/home/presentation/bloc/carousel_slide_bloc/carousel_slide_bloc_state.dart';

class CarouselWidget extends StatelessWidget {
  final List<Widget> carouselItems;

  const CarouselWidget({super.key, required this.carouselItems});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarouselBloc(4)..startCarousel(),
      child: BlocBuilder<CarouselBloc, CarouselState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(30), // Sets the border radius to 5
              ),
              height: 350,
              child: CarouselSlider(
                disableGesture: FutureBuilder.debugRethrowError,
                items: carouselItems,
                options: CarouselOptions(
                  height: 300,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  onPageChanged: (index, reason) {
                    context.read<CarouselBloc>().add(NextCarouselEvent());
                  },
                  viewportFraction: 1.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
