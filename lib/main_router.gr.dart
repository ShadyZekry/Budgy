// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'ui/transactions_screen.dart';

class Routes {
  static const String transactionsScreen = '/';
  static const all = <String>{
    transactionsScreen,
  };
}

class MainRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.transactionsScreen, page: TransactionsScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    TransactionsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TransactionsScreen(),
        settings: data,
      );
    },
  };
}
