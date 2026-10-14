# WhatsApp for Linux - Gray Screen Fix
Date: 2026-10-14 Polaris Guix/XFCE - Don/Meta team

Problem: Flatpak shows gray window, WebKit fails to build framebuffer.
Error: AcceleratedSurfaceDMABuf was unable to construct a complete framebuffer

Fix (flatpak):
flatpak override --user --env=WEBKIT_DISABLE_COMPOSITING_MODE=1 com.github.eneshecan.WhatsAppForLinux
flatpak override --user --env=WEBKIT_DISABLE_DMABUF_RENDERER=1 com.github.eneshecan.WhatsAppForLinux

Test:
flatpak run --env=WEBKIT_DISABLE_COMPOSITING_MODE=1 com.github.eneshecan.WhatsAppForLinux

Override file: ~/.local/share/flatpak/overrides/com.github.eneshecan.WhatsAppForLinux
Upstream: github.com/xeco23/WasIstLos - renamed from eneshecan/whatsapp-for-linux
