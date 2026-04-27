# Google Calendar Sync - Diseño de Arquitectura

## Resumen
Este documento describe la arquitectura para integrar Google Calendar con la aplicación todo_app, permitiendo sincronización bidireccional de eventos.

## Stack Tecnológico
- **Paquetes principales:**
  - `google_sign_in`: ^6.1.0
  - `googleapis`: ^13.0.0
  - `googleapis_auth`: ^1.4.0

## Arquitectura

### 1. Capa de Datos (Data Layer)

#### 1.1 Datasources
- **GoogleCalendarDatasource**: Maneja comunicación directa con API de Google
- **AuthService**: Maneja autenticación OAuth2

#### 1.2 Repositories
- **CalendarSyncRepositoryImpl**: Implementa lógica de sincronización

#### 1.3 Mappers
- **GoogleEventMapper**: Convierte entre EventEntity y Event de Google

### 2. Capa de Dominio (Domain Layer)

#### 2.1 Entidades
- **SyncConfigEntity**: Configuración de sincronización

#### 2.2 Repositories
- **CalendarSyncRepository**: Contrato abstracto

#### 2.3 Use Cases
- **SyncEventsUseCase**: Sincronización completa
- **PushToGoogleUseCase**: Enviar evento a Google
- **PullFromGoogleUseCase**: Obtener eventos de Google
- **ResolveConflictsUseCase**: Resolver conflictos

### 3. Capa de Presentación (Presentation Layer)

#### 3.1 Cubit
- **SyncCubit**: Maneja estado de sincronización

#### 3.2 Widgets
- **SyncStatusWidget**: Muestra estado y botón de sincronización

## Estados de Sincronización

```dart
enum SyncStatus { pending, synced, conflict, error }
```

## Estados del Cubit

- **SyncInitial**: Estado inicial
- **SyncInProgress**: Sincronizando
- **SyncCompleted**: Éxito (con contador)
- **SyncFailed**: Error (con mensaje)
- **SyncConflict**: Conflictos detectados

## Flujo de Sincronización

### Push Local → Google
1. Usuario crea/modifica evento localmente
2. Verificar estado de login
3. Enviar a Google Calendar API
4. Guardar `googleEventId` en BD local
5. Marcar como `isSynced = true`

### Pull Google → Local
1. Obtener eventos de Google (rango de fechas)
2. Comparar con eventos locales
3. Insertar/actualizar según corresponda
4. Resolver conflictos si existen

### Conflict Resolution
- **Last Write Wins**: Comparar `lastSyncedAt`
- **Manual**: Mostrar UI para decisión del usuario
- **Merge**: Combinar cambios no conflictivos

## Modificaciones a BD Existente

### Tabla Events
```dart
TextColumn get googleEventId => text().nullable()();
BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
DateTimeColumn get lastSyncedAt => dateTime().nullable()();
TextColumn get syncStatus => textEnum(SyncStatus.values).nullable()();
```

## Configuración de Plataformas

### Android
- `google-services.json` en `android/app/`
- SHA-1 fingerprint registrado
- Package: `com.example.todo_app`

### iOS
- `GoogleService-Info.plist` en `ios/Runner/`
- Bundle ID: `com.example.todoApp`
- NSCalendarsUsageDescription en Info.plist

## Seguridad

- OAuth 2.0 con scopes mínimos
- Token refresh automático
- Almacenamiento seguro de credenciales
- HTTPS para todas las comunicaciones

## Manejo de Errores

- **Network errors**: Reintentar con exponential backoff
- **Auth errors**: Solicitar login nuevamente
- **Rate limits**: Esperar y reintentar
- **Conflict errors**: Notificar al usuario

## Pruebas

### Unitarias
- AuthService
- GoogleCalendarDatasource (mock)
- Use cases

### Integración
- Flujo completo de sincronización
- Escenarios de conflicto
- Modo offline → online

## Rendimiento

- Sincronización incremental
- Paginación para eventos
- Caché local
- Operaciones en background

## Futuras Mejoras

- Sincronización en tiempo real (webhooks)
- Soporte para múltiples calendarios
- Sincronización de recordatorios
- Calendarios compartidos
- Filtros por categoría