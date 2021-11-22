part of '../login_page/login_page.dart';

Visibility _loginOptionButton(BuildContext context,
    {String title, String icon, bool isVisible, Function onPress}) {
  return Visibility(
    visible: isVisible ?? true,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: context.HEIGHT * .01),
      child: SizedBox(
        width: context.WIDTH * .8,
        child: ElevatedButton(
            onPressed: onPress,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: context.WIDTH * .1,
                    vertical: context.HEIGHT * .01),
                primary: R.color.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                      height: context.HEIGHT * .03,
                      width: context.HEIGHT * .03,
                      child: SvgPicture.asset(
                        icon,
                        fit: BoxFit.contain,
                      )),
                ),
                Expanded(
                  flex: 3,
                  child: Text(title,
                      style: TextStyle(color: R.color.border_color)),
                ),
              ],
            )),
      ),
    ),
  );
}
