import 'package:json_annotation/json_annotation.dart';

/// This allows the `OrganisationModel` class to access private members in
/// the generated file.
part "OrganisationModels.g.dart";

/// @JsonSerializable() is an annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class OrganisationModel {
  //Constructor
  OrganisationModel(
      this.organisation_name,
      this.organisation_email,
      this.organisation_phone,
      this.password,
      this.user_firstName,
      this.user_lastName,
      this.user_email,
      this.username);

  //Parameter variable
  String organisation_name;
  String organisation_email;
  String organisation_phone;
  String password;
  //TODO remove user info and put into User Model or keep here?
  String user_firstName;
  String user_lastName;
  String user_email;
  String username;

/*
  /// A necessary factory constructor for creating a new OrganisationModel instance
  /// from a map. Pass the map to the generated `_$OrganisationModelFromJson()` constructor.
  /// The constructor is named after the source class, in this case, OrganisationModel.
  factory OrganisationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganisationModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$OrganisationModelToJson`.
  Map<String, dynamic> toJson() => _$OrganisationModelToJson(this);
  */
}
