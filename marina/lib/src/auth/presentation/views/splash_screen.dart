import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marina/core/common/app/cache_helper.dart';
import 'package:marina/core/common/widgets/marina_logo.dart';
import 'package:marina/core/res/styles/colours.dart';
import 'package:marina/core/services/injection_container.dart';
import 'package:marina/core/utils/core_utils.dart';
import 'package:marina/src/auth/presentation/app/adapter/auth_adapter.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authAdapterProvider().notifier).verifyToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authAdapterProvider(), (previous, next) async {
      if (next is TokenVerified) {
        if (next.isValid) {
          // TODO (Get-User-Data): Get the user data's data from user adapter
        } else {
          await sl<CacheHelper>().resetSession();
          CoreUtils.postFrammeCall(() => context.go('/'));
        }
      } else if (next is AuthError) {
        if (next.message.startsWith('401')) {
          await sl<CacheHelper>().resetSession();
          CoreUtils.postFrammeCall(() => context.go('/'));
          return;
        }
      }
    });
    return Scaffold(
      backgroundColor: Colours.lightThemeTintStockColour,
      body: Center(child: MarinaLogo()),
    );
  }
}
