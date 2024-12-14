abstract class SideBarStates {}
class SideBarIntitalState extends SideBarStates{}
class LoadUserDataState extends SideBarStates{}
class SuccessUserDataState extends SideBarStates{
  final String? path;
  final String? name;
  SuccessUserDataState(this.path,this.name);
}
class ErrorUserDataState extends SideBarStates{
  final String e;
  ErrorUserDataState(this.e);
}

class MenuSelectedState extends SideBarStates {
  final String selectedMenu;

  MenuSelectedState(this.selectedMenu);
}

class SignOutInProgress extends SideBarStates {}

class SignOutSuccess extends SideBarStates {}

class SignOutFailure extends SideBarStates {
  final String error;

  SignOutFailure(this.error);
}
