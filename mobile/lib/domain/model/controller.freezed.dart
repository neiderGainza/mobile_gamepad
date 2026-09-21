// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Controller {

 String? get id; String? get name; String? get i10ln; String? get description; DateTime get lastEdited;//actual controller
 UnmodifiableListView<PositionedButtonGroup> get buttonGroups;
/// Create a copy of Controller
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ControllerCopyWith<Controller> get copyWith => _$ControllerCopyWithImpl<Controller>(this as Controller, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Controller&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.i10ln, i10ln) || other.i10ln == i10ln)&&(identical(other.description, description) || other.description == description)&&(identical(other.lastEdited, lastEdited) || other.lastEdited == lastEdited)&&const DeepCollectionEquality().equals(other.buttonGroups, buttonGroups));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,i10ln,description,lastEdited,const DeepCollectionEquality().hash(buttonGroups));

@override
String toString() {
  return 'Controller(id: $id, name: $name, i10ln: $i10ln, description: $description, lastEdited: $lastEdited, buttonGroups: $buttonGroups)';
}


}

/// @nodoc
abstract mixin class $ControllerCopyWith<$Res>  {
  factory $ControllerCopyWith(Controller value, $Res Function(Controller) _then) = _$ControllerCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? i10ln, String? description, DateTime? lastEdited, List<PositionedButtonGroup> buttonGroups
});




}
/// @nodoc
class _$ControllerCopyWithImpl<$Res>
    implements $ControllerCopyWith<$Res> {
  _$ControllerCopyWithImpl(this._self, this._then);

  final Controller _self;
  final $Res Function(Controller) _then;

/// Create a copy of Controller
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? i10ln = freezed,Object? description = freezed,Object? lastEdited = freezed,Object? buttonGroups = null,}) {
  return _then(Controller(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,i10ln: freezed == i10ln ? _self.i10ln : i10ln // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,lastEdited: freezed == lastEdited ? _self.lastEdited! : lastEdited // ignore: cast_nullable_to_non_nullable
as DateTime?,buttonGroups: null == buttonGroups ? _self.buttonGroups! : buttonGroups // ignore: cast_nullable_to_non_nullable
as List<PositionedButtonGroup>,
  ));
}

}


/// Adds pattern-matching-related methods to [Controller].
extension ControllerPatterns on Controller {
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
