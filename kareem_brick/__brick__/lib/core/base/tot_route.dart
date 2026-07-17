import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../helper/refreshable_wrapper.dart';

class TotRoute extends GoRoute {
  TotRoute({
    required super.path,
    required super.name,
    super.redirect,
    required Widget Function(BuildContext, GoRouterState) builder,
    bool enableRefresh = true,
  }) : super(
         builder: (context, state) {
           final child = builder(context, state);

           if (!enableRefresh) return child;

           return RefreshableWrapper(child: child);
         },
       );
}
