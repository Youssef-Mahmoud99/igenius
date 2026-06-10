import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/Auth/presentation/cubits/auth_cubit.dart';
import 'injection/service_locator.dart';

class Blocs extends StatelessWidget {
  const Blocs({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => sl<AuthCubit>()),
      ],
      child: child,
    );
  }
}
