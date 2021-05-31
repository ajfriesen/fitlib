// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_image_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseData _$ExerciseDataFromJson(Map<String, dynamic> json) {
  return ExerciseData(
    userId: json['userId'] as String?,
    imageData: (json['imageData'] as List<dynamic>?)
        ?.map((e) => ImageData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ExerciseDataToJson(ExerciseData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'imageData': instance.imageData?.map((e) => e.toJson()).toList(),
    };

ImageData _$ImageDataFromJson(Map<String, dynamic> json) {
  return ImageData(
    exerciseName: json['exerciseName'] as String?,
    imagePath: json['imagePath'] as String?,
  );
}

Map<String, dynamic> _$ImageDataToJson(ImageData instance) => <String, dynamic>{
      'exerciseName': instance.exerciseName,
      'imagePath': instance.imagePath,
    };
