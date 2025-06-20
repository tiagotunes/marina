import 'package:get_it/get_it.dart';
import 'package:marina/core/common/app/cache_helper.dart';
import 'package:marina/src/auth/data/datasources/auth_remote_data_src.dart';
import 'package:marina/src/auth/data/repos/auth_repo_impl.dart';
import 'package:marina/src/auth/domain/repos/auth_repo.dart';
import 'package:marina/src/auth/domain/usecases/forgot_password.dart';
import 'package:marina/src/auth/domain/usecases/login.dart';
import 'package:marina/src/auth/domain/usecases/register.dart';
import 'package:marina/src/auth/domain/usecases/reset_password.dart';
import 'package:marina/src/auth/domain/usecases/verify_otp.dart';
import 'package:marina/src/auth/domain/usecases/verify_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'injection_container.main.dart';
