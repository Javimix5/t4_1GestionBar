# Guía de Despliegue — Bar Vader

---

Versión: 1.0

Fecha: 19 de enero de 2026

Desarrollado por: Javier González Prados

Contacto: javinano@gmail.com

---

## Índice

- [Requisitos previos](#requisitos-previos)
- [Android (APK / AAB) / Play Store](#android-apk--aab--play-store)
- [iOS (App Store)](#ios-app-store)
- [Web (hosting estático)](#web-hosting-estático)
- [Windows / macOS / Linux (Desktop)](#windows--macos--linux-desktop)
- [Publicar en GitHub Releases (opcional)](#publicar-en-github-releases-opcional)
- [Subir la guía a la Wiki de GitHub](#subir-la-gu%C3%ADa-a-la-wiki-de-github)

---

## Requisitos previos

- Tener instalado Flutter (versión estable recomendada) y configurado (`flutter doctor` debe estar limpio). 
- Tener configuradas las herramientas de plataforma:
  - Android: Android Studio / SDK y `adb`.
  - iOS: Xcode (en macOS) y cuenta de desarrollador Apple para publicar en App Store.
  - Web: Chrome u otro navegador para pruebas.
  - Desktop: herramientas de compilación según plataforma (Visual Studio para Windows, toolchain para Linux/macOS).
- Cuenta de Google Play Console para publicar en Play Store.
- Cuenta de App Store Connect y Apple Developer Program para publicar en App Store.

---

## Android (APK / AAB) / Play Store

1. Preparación
   - Incrementa `versionCode` y `versionName` en `android/app/build.gradle` o configura `version` en `pubspec.yaml` según convenga.
   - Configura el `keystore` para firmar la app en `android/key.properties` y `build.gradle`.

2. Generar APK (debug o release)

```bash
# APK de debug
flutter build apk --debug

# APK de release
flutter build apk --release
```

3. Generar AAB (recomendado para Play Store)

```bash
flutter build appbundle --release
```

4. Firmado
- Asegúrate de que el `keystore` esté configurado y que `key.properties` contenga la ruta y contraseñas.
- Verifica el firmado ejecutando el bundle firmado.

5. Subida a Play Console
- Accede a Google Play Console → Crea una app → Sube el `.aab` en "Release" → Rellena fichas, imágenes y políticas → Enviar para revisión.

Notas:
- Usa Play App Signing para mayor seguridad.
- Prueba el `aab` con internal testing antes de producción.

---

## iOS (App Store)

> Requiere macOS con Xcode instalado.

1. Preparación
- Configura el `CFBundleShortVersionString` y `CFBundleVersion` (o la versión en `pubspec.yaml`).
- Asegúrate de tener un Apple Developer account y el dispositivo/simulator configurado.

2. Dependencias

```bash
flutter build ios --release
# Luego abre el proyecto Xcode:
open ios/Runner.xcworkspace
```

3. Archive y firma (Xcode)
- En Xcode selecciona target `Runner` → Generic iOS Device → Product → Archive.
- En Organizer selecciona el archive y pulsa "Distribute App" → App Store Connect → Sigue el flujo (signing automático si está habilitado).

4. Subir a App Store
- Usa Xcode Organizer o `Transporter` para subir el `.ipa` a App Store Connect.
- Completa metadatos y screenshots en App Store Connect y envía a revisión.

Notas:
- Requiere provisión, certificados y configuración de App ID.
- Para pruebas internas utiliza TestFlight.

---

## Web (hosting estático)

1. Construir

```bash
flutter build web --release
```

2. Contenido generado
- El build genera la carpeta `build/web` con `index.html`, `main.dart.js`, `assets`, etc.

3. Opciones de despliegue

- GitHub Pages
  - Crear branch `gh-pages` o usar `gh-pages` action. Copia `build/web` al branch `gh-pages` o usa acciones de GitHub para desplegar.
- Firebase Hosting
  - `npm install -g firebase-tools`
  - `firebase login`
  - `firebase init hosting` (elige `build/web` como carpeta pública)
  - `firebase deploy --only hosting`
- Netlify / Vercel
  - Subir `build/web` como carpeta estática o conectar repositorio y configurar build command `flutter build web` y carpeta `build/web`.

---

## Windows / macOS / Linux (Desktop)

1. Habilitar soporte desktop (si no está activo):

```bash
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop
```

2. Construir ejecutables

```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

3. Empaquetado/Distribución
- Windows: empaqueta el contenido en un instalador MSI o ZIP (utiliza herramientas como Inno Setup o WiX).
- macOS: genera `.app` y firma/notariza si vas a distribuir fuera de App Store.
- Linux: crea paquetes .deb/.rpm o distribuye binarios.

Notas:
- Requiere pruebas en cada plataforma y posible firma de ejecutables según la política de distribución.

---

## Publicar en GitHub Releases (opcional)

1. Crea un release en GitHub (Settings → Releases → Draft a new release).
2. Adjunta los binarios (`.apk`, `.aab`, `.ipa`, builds de escritorio, zip, etc.) al release.
3. Publica la release para que los usuarios puedan descargar las artefactos.

---

## Consejos finales

- Automatiza builds con CI/CD (GitHub Actions) para generar artefactos y publicar automáticamente en Releases o en Firebase/GH Pages.
- Mantén las claves (keystore, certificados) fuera del repo; usa secretos en el servicio CI.
- Documenta los números de versión y notifica en la Wiki cuando cambies los pasos de despliegue.

