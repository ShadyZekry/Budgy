import 'package:budgy/ui/transactions_screen.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: TransactionsScreen, initial: true),
  ],
)
class $MainRouter {}
