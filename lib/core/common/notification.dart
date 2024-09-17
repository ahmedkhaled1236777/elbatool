import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;

sendnotification({required String data}) async {
  String uri = 'https://onesignal.com/api/v1/notifications';
  var url = Uri.parse(uri);

  await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Basic YTY1MjA0NGUtMWJjOS00NTg4LTgyNWYtZjRiNjY3MGUwMWZk',
    },
    body: jsonEncode(
      <String, dynamic>{
        "app_id": "aecb54c7-90d3-48aa-a37f-b55fe381c10a",
        "included_segments": ["All"],
        "data": {"foo": "bar"},
        "contents": {"en": data},
      },
    ),
  );
}
