import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/home/presentation/bloc/bloc_search/search_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/bloc_search/search_event.dart';
import 'package:serve_mate/features/home/presentation/bloc/bloc_search/search_state.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => context.pop(),
        ),
        title: Padding(
          padding: EdgeInsets.only(right: 20.r),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              _controller.value = TextEditingValue(
                text: state.searchText,
                selection:
                    TextSelection.collapsed(offset: state.searchText.length),
              );

              return TextFormField(
                controller: _controller,
                onChanged: (value) {
                  context.read<SearchBloc>().add(SearchTextChanged(value));
                },
                decoration: InputDecoration(
                  hintText: "Search...",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                  isDense: true,
                  border: InputBorder.none,
                  suffixIcon: state.searchText.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, size: 14.sp),
                          onPressed: () {
                            context
                                .read<SearchBloc>()
                                .add(SearchClearPressed());
                          },
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: state.filteredSuggestions.map((item) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<SearchBloc>()
                        .add(SearchTextChanged(item['label']));
                  },
                  child: Chip(
                    avatar: Icon(item['icon'],
                        size: 18.sp, color: AppColors.orange),
                    label: Text(item['label']),
                    backgroundColor: AppColors.backgroundOrange1,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
