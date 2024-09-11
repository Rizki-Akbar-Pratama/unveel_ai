import '../configs/asset_path.dart';

enum LiveConfigurationStep {
  facePosition,
  lightning,
  orientation,
}

extension LiveConfigurationStepExtension on LiveConfigurationStep {
  String get title {
    switch (this) {
      case LiveConfigurationStep.facePosition:
        return "Face Position";
      case LiveConfigurationStep.lightning:
        return "Lightning";
      case LiveConfigurationStep.orientation:
        return "Orientation";
    }
  }

  String iconPath({
    required bool isActive,
  }) {
    switch (this) {
      case LiveConfigurationStep.facePosition:
        if (isActive) {
          return IconPath.facePositionActive;
        }

        return IconPath.facePosition;
      case LiveConfigurationStep.lightning:
        return IconPath.lightning;
      case LiveConfigurationStep.orientation:
        if (isActive) {
          return IconPath.orientationActive;
        }

        return IconPath.orientation;
    }
  }

  bool isActive({
    required LiveConfigurationStep? currentStep,
  }) {
    final currentStepIndex = currentStep?.index;
    if (currentStepIndex == null) {
      return false;
    }

    return currentStepIndex >= index;
  }

  LiveConfigurationStep? get nextStep {
    final nextStepIndex = index + 1;

    if (nextStepIndex >= LiveConfigurationStep.values.length) {
      return null;
    }

    return LiveConfigurationStep.values[nextStepIndex];
  }
}
