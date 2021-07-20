import 'package:edugo_web_app/services/ModelService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/EduGoModel.dart';

BuildContext _mainContext;
// The commands will use this to access the Provided models and services.
void init(BuildContext c) => _mainContext = c;

// Provide quick lookup methods for all the top-level models and services. Keeps the Command code slightly cleaner.
class BaseCommand {
  // Models

  EduGoModel eduGoModel = _mainContext.read();
  // AppModel appModel = _mainContext.read();
  // Services
  ModelService modelService = _mainContext.read();
}
