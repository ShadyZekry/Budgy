import 'package:auto_route/auto_route.dart';
import 'package:budgy/ui/transactions_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: TransactionsScreen, initial: true),
  ],
)
class $AppRouter {}
