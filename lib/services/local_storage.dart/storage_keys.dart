///USE AN ENUM TO ALLOW DEVS KEEP TRACK OF ALL THE
///AVAILABLE STORED PROPERTIES AND KEY NAMES
enum LocalStoreKeysManger {
  appBox('appBox'),
  password('password'),
  token('token'),
  user('user'),
  userPin('userPin'),
  currentState('current_state'),
  refreshToken('refresh_token'),
  rememberMe('rememberMe'),
 
  balanceVisibility('balanceVisibility');

  final String rawValue;

  const LocalStoreKeysManger(this.rawValue);
}
