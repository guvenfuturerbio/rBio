part of 'resources.dart';

class _Constants {
  final date2000 = DateTime(2000, 1, 1, 0, 0, 0);

  final supportedFileExtensions = [
    'docx',
    'pdf',
    'txt',
    'dicom',
    'jpeg',
    'png',
    'jpg',
  ];

  final magazineList = [
    {
      'imagePath': R.image.guvenin_1,
      "magazineUrl": "https://guvenin.com.tr/dergiler/dergi1.html",
      "sayi": "Sayı 1",
    },
    {
      'imagePath': R.image.guvenin_2,
      "magazineUrl": "https://guvenin.com.tr/dergiler/dergi2.html",
      "sayi": "Sayı 2",
    },
    {
      'imagePath': R.image.guvenin_3,
      "magazineUrl": "https://guvenin.com.tr/dergiler/dergi3.html",
      "sayi": "Sayı 3",
    },
    {
      'imagePath': R.image.guvenin_4,
      "magazineUrl": "https://guvenin.com.tr/dergiler/dergi4.html",
      "sayi": "Sayı 4",
    }
  ];

  final onlineAppointmentType = 256;
  final hospitalAppointmentType = 1;
  final tenantAyranciId = 1;
  final tenantCayyoluId = 7;
  final tenantOnlineId = -1;
  final videoCallBoundaryDuration = const Duration(hours: 2);

  final accuCheckSetup = "assets/device/accu_check.mp4";
  final contourPlusOneSetup = "assets/device/contour_plus_one.mp4";
  final miScaleSetup = "assets/device/scale.mp4";

  final userName = "<userName>";
  final adress = "<adress>";
  final phoneNumber = "<phoneNumber>";
  final email = "<email>";
  final paymentPlan = "<paymentPlan>";
  final currentDate = "<currentDate>";
  final packageName = "<packageName>";
  final expirationDate = "<expirationDate>";
  final hospitalEmail = "<hospitalEmail>";

  final grantType = "password";
  final scope = "openid";

  final zoomAppKey = "m8h1pr7xovxPCHgKGo4I6wBqTz8S2MmvsW5i";
  final zoomAppSecret = "phfFqbluB0zJFr3yTB6yP2aJyWcSTH3wC3gw";
  final zoomMeetingRoomPass = "?3/=dL,2/G";

  final chatPersonListKey = "chatPersons";

  final turkey = "Türkiye";

  final tawktoScript = "<script type="
      "text/javascript"
      ">"
      "\n"
      "var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date()"
      "\n"
      "(function(){"
      "\n"
      "var s1=document.createElement("
      "script"
      "),s0=document.getElementsByTagName("
      "script"
      ")[0];"
      "\n"
      "s1.async=true;"
      "\n"
      "s1.src='https://embed.tawk.to/5cb46145c1fe2560f3fee0c1/default';"
      "\n"
      "s1.charset='UTF-8';"
      "\n"
      "s1.setAttribute('crossorigin','*');"
      "\n"
      "s0.parentNode.insertBefore(s1,s0);"
      "\n"
      "})();"
      "\n"
      "</script>";

  final maleData =
      '''m 198.7235,269.85148 a 53.4,53.4 0 0 1 -6.3,-12.277 c -6.166,-17.244 -1.713,-33.473 0.664,-42.138 a 95.155,95.155 0 0 1 5.309,-14.6 c 7.306,-15.79 13.211,-16.749 15.926,-27.539 0.593,-2.356 3.415,-13.573 -1.659,-23.889 -2.613,-5.312 -5.985,-7.672 -8.3,-15.263 -1.253,-4.119 -1.183,-6.453 -1.659,-11.281 -0.383,-3.884 -1.683,-17.06 -5.972,-27.206999 -4.129,-9.768 -10.578,-15.668 -14.489,-19.245 -15.461,-14.142 -33.276,-16.784 -39.815,-17.695 a 76.861,76.861 0 0 0 -29.42,1.548 c -6.7,1.712 -26.400003,7.054 -40.036006,25.659 -14.127,19.274999 -13.439,41.453999 -13.272,44.017999 a 21.1,21.1 0 0 1 0,3.1 c -0.478,6.468 -3.847,10.935 -5.088,12.83 -5.11,7.8 -4.269,17.975 -3.981,21.456 0.444,5.376 2.156,8.23 12.166,25.216 7.3,12.387 10.948,18.58 11.059,18.8 5.275,10.518 13.378003,26.587 8.627003,43.134 -1.233003,4.294 -4.550003,12.866 -14.713003,21.123 a 98.74,98.74 0 0 0 13.5,9.181 c 9.558003,5.4 39.220006,20.043 74.322006,10.617 a 95.507,95.507 0 0 0 43.131,-25.548 z
m -41.015506,312.25148 a 108.5,108.5 0 0 0 -24.481,9.241 c -23.552,12.713 -42.293994,37.084 -47.999994,62.377 -3.909,17.325 -2.146,37.054 -1.77,40.922 a 80.456,80.456 0 0 1 1.549,11.281 61.294,61.294 0 0 1 -1.438,15.926 c -2.77,12.908 -3.58,26.169 -5.972,39.152 -4.885,26.512 0.746,36.547 0.995,100.535 0.028,7.2 -0.092,15.307 -0.332,31.52 -0.411,27.8 -1.244,63.138 -2.986,104.516 a 129.628,129.628 0 0 0 -14.931,17.917 c -4.618,6.693 -15.191,22.015 -19.576,42.47 -1.827,8.524 -1.182,11.42 -4.313,16.922 -1.288,2.262 -5.778,9.471 -7.963,16.59 a 6.058,6.058 0 0 0 0,4.313 c 0,0 1.39,3.034 6.3,3.65 8.6,1.078 20.316,-27.734 22.23,-32.516 a 116.46,116.46 0 0 1 14.267,31.852 c 8.423,30.848 10.286,45.788 10.286,45.788 0.457,3.663 1.017,8.928 4.977,13.272 5.08,5.572 13.516994,7.176 20.239994,5.972 10.535,-1.886 15.968,-10.51 17.917,-13.6 5.208,-8.267 5,-17.681 4.977,-20.9 a 4.811,4.811 0 0 1 -0.083,-2.322 c 0.753,-2.247 3.89,-2.505 6.719,-3.982 a 15.593,15.593 0 0 0 6.3,-6.636 14.3,14.3 0 0 0 0.995,-7.963 c -1.469,-11.872 2.591,-15.851 0,-58.064 -0.347,-5.654 -0.614,-8.792 -1.659,-12.94 -2.433,-9.663 -6.221,-13.447 -8.627,-19.908 -2.665,-7.162 -2.274,-13.963 0,-25.88 6.513,-34.13 16.223,-46.072 20.572,-73.327 3.606,-22.6 2.143,-47.052 1.991,-49.438 -0.709,-11.078 -2.337,-23.67 1.659,-40.147 a 95.77,95.77 0 0 1 5.972,-17.254 c 5.141,-11.586 10.581,-31.734 9.069,-119.668 -0.466,-27.11 -0.729,-40.9 -2.212,-52.645 -3.685,-29.18 -6.724,-40.779 -12.68,-57.019
m 304.3425,363.52448 c -2.692,13.6 -2.6,19.8 -3.981,57.954 -0.326,9.022 -2.737,79.531 1.327,100.424 a 250.959,250.959 0 0 0 6.636,26.1 c 5.212,16.1 10.245,21.839 13.272,32.295 6.039,20.863 3.079,26.555 7.963,55.3 1.353,7.966 4.736,23.006 11.5,53.088 0.463,2.058 4.741,21.07 3.1,39.373 a 64.538,64.538 0 0 1 -3.1,15.484 c -2.521,7.2 -4.9,9.223 -7.078,15.041 -2.178,5.818 -2.218,10.736 -2.212,20.35 0.02,31.795 0.285,17.779 1.327,48.222 0.258,7.537 0.518,13.8 4.535,19.686 2.585,3.792 4.667,6.844 8.626,9.29 2.855,1.764 6.139,2.875 6.968,5.862 a 6.3,6.3 0 0 1 -0.221,3.65 c -1.807,6.088 3.6,24.112 16.369,27.428 12.15,3.157 22.909,-9.1 23.447,-9.732 4.13,-4.843 5.408,-9.8 7.078,-17.254 4.463,-19.93 6.806,-35.788 7.078,-37.6 a 172.06,172.06 0 0 1 11.5,-40.7 c 1.386,3.3 12.748,29.947 22.12,31.853 1.394,0.283 4.562,0.928 6.636,-0.885 2.074,-1.813 1.789,-5.028 1.77,-5.309 -0.26,-3.728 -3.791,-6.246 -4.867,-7.078 -3.437,-2.66 -6.863,-11.506 -13.714,-29.2 -6.57,-16.968 -7.249,-21.313 -12.829,-27.429 a 44.06,44.06 0 0 0 -9.733,-7.963 c -7.774,-56.336 -7.771,-99.317 -6.194,-128.737 0.984,-18.35 3.071,-40.576 0,-72.11 a 525.619,525.619 0 0 0 -9.179,-60.387 c -4.046,-17.606 -5.914,-20.184 -6.636,-31.189 -1.289,-19.645 3.638,-27.044 2.654,-48.111 -0.362,-7.749 -0.84,-17.976 -4.977,-29.861 -1.843,-5.3 -12.593,-34.7 -42.8,-49.438 a 79.805,79.805 0 0 0 -20.973,-6.812 226.7,226.7 0 0 0 -15.412,48.395 z
m -6.5755054,577.72848 a 334.334,334.334 0 0 1 -9.3730006,-39.015 605.967,605.967 0 0 1 -10.175,-116.793 c -0.466,-27.11 -0.729,-40.9 -2.212,-52.645 -3.685,-29.18 -6.724,-40.779 -12.68,-57.019 4.51,-1.191 9.157,-2.256 14.007,-3.368 16.669,-3.82 17.4490001,-1.971 33.1800006,-5.308 16.6399994,-3.531 36.3559994,-7.929 54.6359994,-22.341 2.391,-1.886 4.738,-3.736 6.964,-5.642 a 98.74,98.74 0 0 0 13.5,9.181 c 9.558003,5.4 39.220006,20.043 74.322006,10.617 a 95.507,95.507 0 0 0 43.13,-25.544 c 9.1,12.827 22.516,17.888 35.5,22.23 24.366,8.148 42.215,12.092 66.691,18.249 7.409,1.864 13.633,3.433 18.842,4.8 a 226.7,226.7 0 0 0 -15.414,48.4 c -2.692,13.6 -2.6,19.8 -3.981,57.954 0,0 -3.723,78.5 -11.5,104.4 -0.251,0.834 -2.222,7.332 -4.867,16.369 0,0 -4.249,14.528 -7.078,24.774 a 113.616,113.616 0 0 0 -2.946,15.4 c -52.173,13.2 -124.752,23.655 -208.630006,11.252 a 516.691,516.691 0 0 1 -71.9159994,-15.951 z
m 293.4845,949.03848 c 0.185,-3.808 0.34,-8.315 0.465,-13.939 1.289,-58.022 -3.507,-106.723 -7.963,-150.636 -2.976,-29.323 -2.937,-21.909 -9.29,-78.967 0,0 -8.629,-77.492 -2.725,-123.068 -52.173,13.2 -124.752,23.655 -208.630006,11.252 a 516.691,516.691 0 0 1 -71.9169994,-15.952 246.149,246.149 0 0 1 5.669,25.132 c 10.6709996,59.376 6.707,108.272 1.769,164.571 -4.665,53.193 -7.511,43.146 -10.1750005,82.728 -0.7650001,11.368 -1.7640001,30.529 2.3480005,106.015 a 482.958,482.958 0 0 0 130.6380054,20.662 h 0.018 c 1.734,-7.653 3.693,-16.182 5.908,-25.815 2.066,-8.982 3.976,-21.545 6.453,-35.317 q 0.85,-0.082 1.7,-0.2 c 7.072,19.21 11.274,36.66 16.175,50.784 0.959,2.764 2.116,6.11 3.4,10.009 a 483.843,483.843 0 0 0 136.242,-27.016
m 293.5695,949.28148 a 483.842,483.842 0 0 1 -136.235,27.016 c 3.257,9.863 7.349,23.26799 11.2,39.76002 8.149,34.936 4.777,39.059 11.945,76.314 7.529,39.133 12.408,40.608 18.58,78.967 3.488,21.675 5.76,35.8 5.309,55.742 -0.755,33.363 -8.078,36.389 -5.972,63.041 1.424,18.025 5.009,19.626 11.281,54.415 0,0 3.683,20.427 5.972,41.806 5.348,49.935 0.082,132.568 -9.29,177.843 -1.2,5.812 -4.7,21.788 3.981,31.853 1.393,1.614 5.235,5.549 15.263,7.963 23.164,5.575 57.627,-2.194 65.032,-23.226 2.846,-8.084 1.034,-16.247 -0.663,-23.889 -2.863,-12.891 -7.625,-15.4 -11.945,-29.2 -2.655,-8.482 -3.1,-14.945 -3.982,-27.871 -1.108,-16.2 -0.311,-25.962 0,-37.825 0.763,-29.037 -2.382,-32.635 -1.99,-53.087 0.43,-22.484 4.454,-29.9 9.953,-59.06 11.232,-59.555 9.478,-108.332 8.627,-128.737 -0.882,-21.166 -1.959,-16.647 -3.981,-46.452 -1.4,-20.629 -3.724,-64.642 0.663,-147.981 3,-57.01602 5.092,-55.47602 6.171,-77.63702
m 123.6915,976.84048 h -0.018 a 482.9,482.9 0 0 1 -130.6370054,-20.663 c 0.881,16.181 2,34.951 3.4,56.78802 4.06,63.13 6.047,82.284 3.1,117.234 -2.412,28.578 -5.381,35.192 -8.4060005,65.475 -4.3370001,43.417 -2.7750001,75.258 -0.442,119 1.5270005,28.637 9.2610005,156.008 10.6180005,179.613 a 93.835,93.835 0 0 1 -1.328,25.216 c -2.313,11.653 -5.446,14.814 -9.7320005,30.083 -3.9320001,14.006 -5.9000001,21.009 -4.4240001,26.986 4.6570001,18.885 32.895,25.265 36.718,26.1 7.227,1.581 28.826,6.28 42.028,-5.309 a 32.187,32.187 0 0 0 8.406,-12.387 39.069,39.069 0 0 0 2.212,-11.5 c 0.244,-9.205 -4.555,-42.47 -5.752,-61.493 -0.75,-11.931 0.42,-10.254 -0.442,-23.447 -1.207,-18.476 -4.044,-30.048 -5.751,-39.374 -6.175,-33.725 -2.113,-62.8 -0.442,-74.764 2.852,-20.424 6.257,-18.544 11.5,-46.894 a 311.146,311.146 0 0 0 5.751,-50.433 c 0.819,-33.079 -5.556,-33.536 -4.424,-57.954 0.985,-21.244 5.830003,-21.324 18.581003,-70.783 4.276,-16.587 9.057003,-35.334 12.829003,-59.724 4.315,-27.9 1.91,-28.28 5.751,-56.626 1.947,-14.359 5.216,-30.044 10.904,-55.14402 z'''
          .split('\n');

  final femaleData =
      '''M420.694,393.141a182.547,182.547,0,0,1-82.83,10.733,176.519,176.519,0,0,1-36.658-7.953,74.257,74.257,0,0,0,6.052-5.522l-.047.047c-5.938-5.932-11.116-11.242-15.467-15.77-21.1-21.966-24.968-27.854-27.871-33.18-3.544-6.505-10.785-20.149-11.281-38.488-.277-10.264,2.466-19.591,7.963-37.825,8.032-26.642,10.486-24.3,14.6-41.807,4.454-18.959,2.342-24.961,8.627-44.46,3.463-10.745,5.2-16.118,8.627-21.235,17.085-25.477,57.9-25.272,69.013-25.217,14.5.073,51.713.259,69.014,24.553,7.351,10.322,10.869,24.66,13.936,37.161,3,12.24,2.455,15.978,5.308,28.535,4.468,19.661,9.872,28.376,13.272,38.488,11.058,32.883-3.641,66.958-7.963,76.977A129.78,129.78,0,0,1,416.135,388.5l0,0c1.567,1.7,3.129,3.22,4.618,4.573
M244.611,494.637c5.017-8.6,9.412-17.825,13.205-33a137.87,137.87,0,0,0,3.061-50.027c-4.162.136-11.221.319-26.883,1.075-7.523.363-11.3.546-11.945.663-19,3.432-30.906,21.869-36.5,30.525-10.723,16.6-13.353,32.46-14.6,40.48a113.542,113.542,0,0,0-1.328,19.244C170,541.443,166.5,614.779,161,661.531c-2.9,24.65-4.793,40.707-10.618,63.041-16.5,63.279-45.342,103.167-59.723,112.811-6.4,4.291-11.81,9.9-17.917,14.6-5.751,4.422-9.781,7.271-10.286,11.945a11.835,11.835,0,0,0,4.314,10.286c5.015,3.89,13.833,2.911,19.907-3.65a99.748,99.748,0,0,1-7.3,22.562c-4.95,10.667-9.495,15.307-8.627,23.226.1.934.963,7.878,6.3,12.608,11.848,10.491,33.818-.47,34.839-.995,13.789-7.092,19.871-19.6,23.889-27.871,6.526-13.425,8.5-27.148,11.281-46.452,1.116-7.749,1.173-10.459,2.655-16.921a129.139,129.139,0,0,1,10.949-29.53c13.742-28,20.927-35.028,30.193-54.083,7.3-15.019,10.917-26.85,14.268-37.825,2.183-7.149,10.566-35.536,13.935-82.949,2.309-32.493-.666-32.7,1.327-53.751C222.4,557.341,228.182,528.486,244.611,494.637Z
M490.8,500.942a130.459,130.459,0,0,1-14.259-34.956,137.971,137.971,0,0,1-2.778-52.2c7.63.45,13.41-.087,24.336,1.887,9.082,1.64,18.591,4.449,23.889,6.968,10.266,4.879,19.1,15.495,29.862,50.764,7.763,25.44,10.019,42.372,19.908,102.525,4.641,28.231,5.333,31.735,5.972,34.839,8.72,42.342,14.8,45.3,20.9,74.654,8.132,39.118.19,47.611,9.954,93.567,1.25,5.88,1.432,20.96,9.954,36.829a79.633,79.633,0,0,0,10.95,15.927c4.444,4.993,16.676,18.735,25.88,23.889a8.038,8.038,0,0,1,3.318,3.207,9.247,9.247,0,0,1-1.328,9.954c-3.126,3.527-8.146,2.906-10.175,2.655-6.74-.835-10.735-5.952-11.723-7.3,2.362,17.956,6.92,27.4,10.839,32.737,1.387,1.891,5.705,7.371,5.751,14.821a21.574,21.574,0,0,1-1.327,7.3,26.229,26.229,0,0,1-16.148,15.263c-13.5,4.156-26.873-7.682-31.189-11.5-15.6-13.813-19.364-33.182-21.9-46.231-.87-4.479-1.834-16.848-3.761-41.585-1.207-15.5-1.234-17.177-1.548-20.571-2.535-27.373-12.863-44.7-21.014-65.254-2.526-6.368-7.027-26.673-15.926-67.023-15.607-70.762-15.306-75.173-21.9-100.2A729.392,729.392,0,0,0,490.8,500.942Z
M461.8,613.582A439.66,439.66,0,0,1,336.4,624.8a436.464,436.464,0,0,1-71.3-9.891h0q-.8-4.895-1.585-9.464c-1.456-8.556-2.964-16.281-4.376-22.975-13.569-5.578-19.6-19.252-21.173-22.813-3.9-8.848-3.982-16.535-3.981-23.225,0-8.357,1.255-23.794,10.617-41.807,5.016-8.6,9.411-17.825,13.2-33a137.864,137.864,0,0,0,3.06-50.027c2.178-.071,3.562-.13,4.97-.252,12.305-1.063,24.975-6.79,35.342-15.252a176.521,176.521,0,0,0,36.658,7.953,182.545,182.545,0,0,0,82.83-10.733l.057-.063a75.978,75.978,0,0,0,9.684,7.478c16.906,11.06,37.059,12.581,41.807,12.94q.786.059,1.543.1h-.1a137.976,137.976,0,0,0,2.778,52.2A130.451,130.451,0,0,0,490.7,500.932h.1a65.908,65.908,0,0,1,3.982,39.152c-1.335,6.259-4.186,19.627-15.926,29.862a48.715,48.715,0,0,1-11.947,7.605v0c-2.072,13.1-3.738,25.139-5.084,36.037
M461.876,613.412c-1.569,12.705-2.7,23.858-3.54,33.337-1.416,16.032-2.492,33.024,1.327,54.414,2.923,16.373,7.343,27.648,10.617,36.5,0,0,11.061,29.893,25.217,86.267a243.5,243.5,0,0,1,7.154,54.86c-12.325,3.8-26.2,7.547-41.44,10.836a498.95,498.95,0,0,1-81.239,10.629q1.29-11.555,3.046-23.9c-.88,1.026-10.093,11.413-23.889,9.954a27.351,27.351,0,0,1-16.258-7.963q1.5,11.477,2.683,22.336c-10.544-.251-19.155-.815-25.467-1.322a475.226,475.226,0,0,1-83.8-14.385c-.056-7.551.186-15.034.737-23.219,1.655-24.548,3.156-46.8,12.609-74.654,6.608-19.471,11.739-25.878,16.59-46.784,4.864-20.966,4.916-36.986,4.976-56.073.09-27.979-2.961-50.6-6.046-69.5h0a436.44,436.44,0,0,0,71.3,9.891,439.649,439.649,0,0,0,125.391-11.221
M502.617,878.788c-12.325,3.8-26.2,7.547-41.439,10.836a498.961,498.961,0,0,1-81.24,10.629,736.616,736.616,0,0,0-4.585,91.564c.133,10.221,1.377,89.638,11.945,153.954a272.673,272.673,0,0,1,3.982,38.488c.546,17.963-.882,31.08-3.982,58.4-6.211,54.717-6.143,51.969-6.636,57.733-2.274,26.588.225,38.994,5.309,90.912,6.672,68.14,10.008,102.21,8.626,132.055-2.11,45.589-3.166,68.383-7.3,78.968a28.272,28.272,0,0,0-1.991,13.935c1.728,13.91,14.71,22.66,16.59,23.89,18.849,12.325,44.269,4.861,58.4-5.309,4.588-3.3,12.788-9.206,14.6-19.244,1.39-7.7-1.554-14.654-2.654-17.254a40.2,40.2,0,0,0-9.29-13.272c-10.179-10.036-15.819-24.507-22.563-41.806-2.485-6.375-7.971-22.576-4.645-63.041,3.023-36.776,11.159-67.249,25.88-121.438,6.5-23.925,9.765-34.031,9.954-51.1.178-16.028-2.754-30.369-8.626-58.4-6.717-32.06-8.679-33.263-10.618-45.788-4.939-31.908,2.766-56.6,9.29-80.294,0,0,11.974-43.487,26.544-122.765C496.219,956.617,503.406,917.507,502.617,878.788Z
M345.52,900.679c-10.543-.251-19.154-.815-25.466-1.322a475.226,475.226,0,0,1-83.8-14.385c.15,20.421,2.474,41.337,6.71,77.979,6.97,60.3,8.648,90.647,14.267,120.442,3.417,18.12,6.41,36.319,9.954,54.415,5.229,26.7,6.846,32.321,7.3,45.124a159.808,159.808,0,0,1-5.972,50.433,159.107,159.107,0,0,1-8.627,22.562c-8.714,19.835-7.877,43.638,4.645,103.521,9.817,46.941,17.187,70.02,24.553,118.783,2.889,19.124,4.164,31.517,1.327,47.115-.647,3.562-8.45,44.727-27.207,62.378a35.317,35.317,0,0,0-9.954,14.6c-.156.459-2.753,8.307-1.327,15.263,3.094,15.085,25.254,26.677,45.124,25.216,19.049-1.4,35.845-14.786,41.143-30.525,3.969-11.79-.332-19.5-4.645-39.816-4.124-19.421-4.519-35.067-5.309-66.359-.179-7.1-.364-22,5.309-77.64,6.705-65.753,8.378-58.818,9.29-81.622,1.487-37.157-3.61-39.2-6.636-102.857-1.043-21.963-2.365-51.236-.663-86.931,2-41.964,7.171-71.647,9.29-85.6C350.409,1034.686,354.134,979.795,345.52,900.679Z'''
          .split('\n');

  String json = 'json';
}
