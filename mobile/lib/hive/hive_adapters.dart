import 'package:core/core.dart';
import 'package:flutter/painting.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/domain/model/button_data.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/domain/model/positioned_button_group.dart';
import 'package:hive_ce_flutter/adapters.dart';

@GenerateAdapters([
  AdapterSpec<BoxShape>(),
  AdapterSpec<Button>(),
  AdapterSpec<ButtonData>(),
  AdapterSpec<PlayerButton>(),
  AdapterSpec<Offset>(),
  AdapterSpec<Controller>(),
  AdapterSpec<ButtonGroup>(),  
  AdapterSpec<PositionedButtonGroup>(),  
  AdapterSpec<ButtonType>(),
  
  AdapterSpec<Player>()
])
part 'hive_adapters.g.dart';
