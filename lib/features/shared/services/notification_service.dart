import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

var logger = Logger();

class NotificationService {

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
    FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    
    //establece el horario por pais.
    tz.initializeTimeZones();

    //Configuracion para Android. Usamos el icono '@mipmap/ic_launcher' porque es el por defecto en flutter.
    const AndroidInitializationSettings initializationSettingsAndroid = 
      AndroidInitializationSettings('@mipmap/ic_launcher');

    //Configuracion para IOS.
    const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,

        // Para mostrar la notificación aunque este la app abierta.
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
      );

    //Unifico las configuraciones. Aplicando el patron Singleton.
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // Muestra un mensaje si el usuario toca la notificacion.
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        logger.i("Tocaron la notificacion con payload: ${response.payload}");
      },
    );   

  }

  Future<void> requestPermissions() async {

    //Solicitamos permisos al usuario de android para usar las notificaciones.
    final androidImplementation = flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
     
    if (androidImplementation != null){
      await androidImplementation.requestNotificationsPermission();

      await androidImplementation.requestExactAlarmsPermission();
    }

    //Solicitamos permisos al usuario de IOS para usar las notificaciones.
    final iOSImplementation = flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

    if (iOSImplementation != null){
      await iOSImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {


    // Establece la zona horaria del celular.
    final tz.TZDateTime tzDate = tz.TZDateTime.from(
      scheduledDate,
      tz.local,
    );

    if (tzDate.isBefore(tz.TZDateTime.now(tz.local))) {
      logger.i("La fecha $tzDate ya pasó. No se programó nada.");
      return;
    }

    // Android
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_tareas_id', 
      'Mis Tareas',
      channelDescription: 'Canal para recordatorios de tareas.',
      // Con este nivel de importancia vibra el celular y suena la notificacion.
      importance: Importance.max,
      // Para prioridad visual dentro de la barra de notificaciones.
      priority: Priority.high,
    );

    // iOS
    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      sound: 'default',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Unificamos las llamadas a la funcion.
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, 
      title, 
      body, 
      tzDate, 
      details, 
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    
    logger.i(
      "La notificación con id: $id titulo: $title, dia: $tzDate", 
    );
  }


}