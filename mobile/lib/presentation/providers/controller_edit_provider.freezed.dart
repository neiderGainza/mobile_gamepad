// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'controller_edit_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ControllerEditState {

 Controller get controller; int? get selectedButtonIndex; int? get selectedGroupIndex;
/// Create a copy of ControllerEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ControllerEditStateCopyWith<ControllerEditState> get copyWith => _$ControllerEditStateCopyWithImpl<ControllerEditState>(this as ControllerEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ControllerEditState&&(identical(other.controller, controller) || other.controller == controller)&&(identical(other.selectedButtonIndex, selectedButtonIndex) || other.selectedButtonIndex == selectedButtonIndex)&&(identical(other.selectedGroupIndex, selectedGroupIndex) || other.selectedGroupIndex == selectedGroupIndex));
}


@override
int get hashCode => Object.hash(runtimeType,controller,selectedButtonIndex,selectedGroupIndex);

@override
String toString() {
  return 'ControllerEditState(controller: $controller, selectedButtonIndex: $selectedButtonIndex, selectedGroupIndex: $selectedGroupIndex)';
}


}

/// @nodoc
abstract mixin class $ControllerEditStateCopyWith<$Res>  {
  factory $ControllerEditStateCopyWith(ControllerEditState value, $Res Function(ControllerEditState) _then) = _$ControllerEditStateCopyWithImpl;
@useResult
$Res call({
 Controller controller, int? selectedButtonIndex, int? selectedGroupIndex
});




}
/// @nodoc
class _$ControllerEditStateCopyWithImpl<$Res>
    implements $ControllerEditStateCopyWith<$Res> {
  _$ControllerEditStateCopyWithImpl(this._self, this._then);

  final ControllerEditState _self;
  final $Res Function(ControllerEditState) _then;

/// Create a copy of ControllerEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? controller = null,Object? selectedButtonIndex = freezed,Object? selectedGroupIndex = freezed,}) {
  return _then(ControllerEditState(
controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as Controller,selectedButtonIndex: freezed == selectedButtonIndex ? _self.selectedButtonIndex : selectedButtonIndex // ignore: cast_nullable_to_non_nullable
as int?,selectedGroupIndex: freezed == selectedGroupIndex ? _self.selectedGroupIndex : selectedGroupIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ControllerEditState].
extension ControllerEditStatePatterns on ControllerEditState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
