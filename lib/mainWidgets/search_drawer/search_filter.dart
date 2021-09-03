import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';

import 'choose_category/selected_category_1.dart';
import 'choose_category/selected_category_10.dart';
import 'choose_category/selected_category_11.dart';
import 'choose_category/selected_category_12.dart';
import 'choose_category/selected_category_13.dart';
import 'choose_category/selected_category_14.dart';
import 'choose_category/selected_category_15.dart';
import 'choose_category/selected_category_16.dart';
import 'choose_category/selected_category_17.dart';
import 'choose_category/selected_category_18.dart';
import 'choose_category/selected_category_19.dart';
import 'choose_category/selected_category_2.dart';
import 'choose_category/selected_category_20.dart';
import 'choose_category/selected_category_21.dart';
import 'choose_category/selected_category_3.dart';
import 'choose_category/selected_category_4.dart';
import 'choose_category/selected_category_5.dart';
import 'choose_category/selected_category_6.dart';
import 'choose_category/selected_category_7.dart';
import 'choose_category/selected_category_8.dart';
import 'choose_category/selected_category_9.dart';



class SearchFilter extends StatelessWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchDrawerProvider>(builder: (context, searchDrawer, child) {
      if (searchDrawer.selectedCategory == '0') {
        return Container();
      } else if (searchDrawer.selectedCategory == '1') {
        return SelectedCategory1();
      } else if (searchDrawer.selectedCategory == '2') {
        return SelectedCategory2();
      } else if (searchDrawer.selectedCategory == '3') {
        return SelectedCategory3();
      } else if (searchDrawer.selectedCategory == '4') {
        return SelectedCategory4();
      } else if (searchDrawer.selectedCategory == '5') {
        return SelectedCategory5();
      } else if (searchDrawer.selectedCategory == '6') {
        return SelectedCategory6();
      } else if (searchDrawer.selectedCategory == '7') {
        return SelectedCategory7();
      } else if (searchDrawer.selectedCategory == '8') {
        return SelectedCategory8();
      } else if (searchDrawer.selectedCategory == '9') {
        return SelectedCategory9();
      } else if (searchDrawer.selectedCategory == '10') {
        return SelectedCategory10();
      } else if (searchDrawer.selectedCategory == '11') {
        return SelectedCategory11();
      } else if (searchDrawer.selectedCategory == '12') {
        return SelectedCategory12();
      } else if (searchDrawer.selectedCategory == '13') {
        return SelectedCategory13();
      } else if (searchDrawer.selectedCategory == '14') {
        return SelectedCategory14();
      } else if (searchDrawer.selectedCategory == '15') {
        return SelectedCategory15();
      } else if (searchDrawer.selectedCategory == '16') {
        return SelectedCategory16();
      } else if (searchDrawer.selectedCategory == '17') {
        return SelectedCategory17();
      } else if (searchDrawer.selectedCategory == '18') {
        return SelectedCategory18();
      } else if (searchDrawer.selectedCategory == '19') {
        return SelectedCategory19();
      } else if (searchDrawer.selectedCategory == '20') {
        return SelectedCategory20();
      } else if (searchDrawer.selectedCategory == '21') {
        return SelectedCategory21();
      }else{
        return Container();
      }
    });
  }
}
