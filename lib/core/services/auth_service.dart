import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory/core/models/inventory_user.dart';

class AuthService {
  static InventoryUser? _currentUser;

  static final _userStream = Stream<InventoryUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toInventoryUser(user);
      controller.add(_currentUser);
    }
  });


  InventoryUser? get currentUser {
    return _currentUser;
  }

  Stream<InventoryUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
      String name, String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) return;

    // 1. atualizar os atributos do usuário
    await credential.user?.updateDisplayName(name);

    // 3. salvar usuário no banco de dados (opcional)
    _currentUser = _toInventoryUser(credential.user!, name);
    await _saveInventoryUser(_currentUser!);
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  static InventoryUser _toInventoryUser(User user, [String? name]) {
    return InventoryUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!
    );
  }

  Future<void> _saveInventoryUser(InventoryUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'permission': 'U',
    });
  }

}