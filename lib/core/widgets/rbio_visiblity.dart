import 'package:flutter/material.dart';

import '../core.dart';

/// Herhangi bir widget'ın görünürlüğü temadan temaya değişiyorsa, widget'ı 'RbioVisibility' ile sar.
class RbioVisibility extends StatelessWidget {
  final Widget child;
  final bool isShow;

  const RbioVisibility({
    Key key,
    @required this.isShow,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => isShow ? child : SizedBox();
}

/// Toplantıda bahsedilecek konular:
///  - [Tema] 
///     Uygulama'da hangi temalar olacak.
///     Temaya göre uygulama mı çıkacak yoksa uygulama içerisinde diğer temalara geçiş olabilecek mi?
///  - [Kullanıcı Tipleri]
///     Kaç farklı tipte kullanıcı olacak?
///     Örneğin; Doktor - Default User - Premium User. Hangi kullanıcı hangi sayfaları görüntüleyebilecek.
///  -
