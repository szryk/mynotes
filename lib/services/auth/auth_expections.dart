//Login exception
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//register exceptions
class WeakPasswordAuthExpection implements Exception {}

class EmailAlreadyInUseAuthExpection implements Exception {}

class InvalidEmailAuthExpection implements Exception {}

//generic exception
class GenericAuthExpection implements Exception {}

class UserNotLoggedInAuthExpection implements Exception {}
