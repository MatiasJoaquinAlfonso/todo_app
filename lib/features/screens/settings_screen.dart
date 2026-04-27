import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/calendar_sync/presentation/cubit/calendar_sync_cubit.dart';
import 'package:todo_app/features/todo/presentation/cubit/theme_cubit/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          children: [
            // Header
            Text(
              'Ajustes',
              style: GoogleFonts.manrope(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 32),

            // Productivity Stats
            Row(
              children: [
                Expanded(
                  child: _BentoCard(
                    title: 'Focus Score',
                    value: '84',
                    subtitle: '+5% esta semana',
                    icon: Icons.track_changes_rounded,
                    isDark: isDark,
                    cs: cs,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _BentoCard(
                    title: 'Archived',
                    value: '128',
                    subtitle: 'Tareas',
                    icon: Icons.archive_outlined,
                    isDark: isDark,
                    cs: cs,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Appearance
            _SectionTitle(title: 'Apariencia', cs: cs),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isDark ? cs.surfaceContainerLow : cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: cs.outlineVariant.withAlpha(isDark ? 30 : 50)),
              ),
              child: _SettingItem(
                icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                title: 'Modo Oscuro',
                trailing: CupertinoSwitch(
                  value: isDark,
                  activeTrackColor: cs.primary,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
                isDark: isDark,
                cs: cs,
              ),
            ),
            const SizedBox(height: 24),

            // Organization
            _SectionTitle(title: 'Organización', cs: cs),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isDark ? cs.surfaceContainerLow : cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: cs.outlineVariant.withAlpha(isDark ? 30 : 50)),
              ),
              child: _SettingItem(
                icon: Icons.folder_outlined,
                title: 'Gestionar Categorías',
                trailing: Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
                onTap: () => context.push('/categories'),
                isDark: isDark,
                cs: cs,
              ),
            ),
            const SizedBox(height: 24),

            // Integrations - Google Calendar
            _SectionTitle(title: 'Integraciones', cs: cs),
            const SizedBox(height: 12),
            BlocBuilder<CalendarSyncCubit, CalendarSyncState>(
              builder: (context, calendarState) {
                return Container(
                  decoration: BoxDecoration(
                    color: isDark ? cs.surfaceContainerLow : cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: cs.outlineVariant.withAlpha(isDark ? 30 : 50)),
                  ),
                  child: Column(
                    children: [
                      _SettingItem(
                        icon: Icons.calendar_today_rounded,
                        title: 'Google Calendar',
                        trailing: calendarState.authStatus == GoogleAuthStatus.connecting
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: cs.primary,
                                ),
                              )
                            : CupertinoSwitch(
                                value: calendarState.isConnected,
                                activeTrackColor: cs.primary,
                                onChanged: (value) async {
                                  if (value) {
                                    await context.read<CalendarSyncCubit>().signIn();
                                  } else {
                                    await context.read<CalendarSyncCubit>().signOut();
                                  }
                                },
                              ),
                        isDark: isDark,
                        cs: cs,
                        showDivider: calendarState.isConnected,
                      ),
                      // Mostrar info de la cuenta conectada
                      if (calendarState.isConnected)
                        _GoogleAccountInfo(
                          email: calendarState.userEmail ?? '',
                          displayName: calendarState.userDisplayName ?? '',
                          photoUrl: calendarState.userPhotoUrl,
                          isDark: isDark,
                          cs: cs,
                        ),
                      // Mostrar error si hubo uno
                      if (calendarState.authStatus == GoogleAuthStatus.error &&
                          calendarState.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, size: 16, color: cs.error),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  calendarState.errorMessage!,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: cs.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Notifications
            _SectionTitle(title: 'Notificaciones', cs: cs),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isDark ? cs.surfaceContainerLow : cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: cs.outlineVariant.withAlpha(isDark ? 30 : 50)),
              ),
              child: Column(
                children: [
                  _SettingItem(
                    icon: Icons.notifications_none_rounded,
                    title: 'Push Notifications',
                    trailing: CupertinoSwitch(
                      value: true,
                      activeTrackColor: cs.primary,
                      onChanged: (value) {},
                    ),
                    isDark: isDark,
                    cs: cs,
                    showDivider: true,
                  ),
                  _SettingItem(
                    icon: Icons.volume_up_outlined,
                    title: 'Alert Sound',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Chime',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
                      ],
                    ),
                    isDark: isDark,
                    cs: cs,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 100), // Padding for nav bar
          ],
        ),
      ),
    );
  }
}

/// Widget que muestra la información de la cuenta de Google conectada
class _GoogleAccountInfo extends StatelessWidget {
  final String email;
  final String displayName;
  final String? photoUrl;
  final bool isDark;
  final ColorScheme cs;

  const _GoogleAccountInfo({
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.isDark,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: cs.primaryContainer,
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
            child: photoUrl == null
                ? Icon(Icons.person, size: 18, color: cs.primary)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (displayName.isNotEmpty)
                  Text(
                    displayName,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                Text(
                  email,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Conectado',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4CAF50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BentoCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final bool isDark;
  final ColorScheme cs;

  const _BentoCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.isDark,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? cs.surfaceContainerLow : cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cs.outlineVariant.withAlpha(isDark ? 30 : 50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? cs.surfaceContainer : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: cs.primary),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: cs.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final ColorScheme cs;

  const _SectionTitle({required this.title, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: cs.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;
  final bool isDark;
  final ColorScheme cs;
  final bool showDivider;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.trailing,
    this.onTap,
    required this.isDark,
    required this.cs,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: cs.outlineVariant.withAlpha(isDark ? 30 : 50),
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark ? cs.surfaceContainer : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: cs.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}