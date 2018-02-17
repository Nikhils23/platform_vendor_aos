# Inherit common AOS stuff
$(call inherit-product, vendor/aos/config/telephony.mk)

$(call inherit-product, vendor/aos/config/aos_props.mk)

$(call inherit-product, vendor/aos/config/version.mk)

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/aos/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/aos/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/aos/prebuilt/common/bin/50-aos.sh:system/addon.d/50-aos.sh
    vendor/aos/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/aos/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/aos/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Aos-specific init file
PRODUCT_COPY_FILES += \
    vendor/aos/prebuilt/common/etc/init.local.rc:root/init.aos.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/aos/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/aos/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/aos/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/aos/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/aos/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Aos-specific startup services
PRODUCT_COPY_FILES += \
    vendor/aos/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/aos/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Required packages
PRODUCT_PACKAGES += \
    SpareParts \
    LockClock

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Extra AOS packages
PRODUCT_PACKAGES += \
    ExactCalculator \
    LatinIME \
    BluetoothExt \
    Retro \
    Etar \
    Turbo \
    Launcher3 \
    DarknessHub \
    GodlyTorch \
    OmniJaws

# Themes
PRODUCT_PACKAGES += \
    DeepPurpleTheme \
    IndigoTheme \
    PinkTheme \
    PurpleTheme \
    RedTheme \
    SkyBlueTheme \
    YellowTheme \
    PixelTheme \
    Stock

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g


PRODUCT_PACKAGES += \
    charger_res_images

# DU Utils library
PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# DU Utils library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

#MusicFX
ifeq ($(WITH_MUSICFX),true)
PRODUCT_PACKAGES += \
    MusicFX \
    audio_effects.conf \
    libcyanogen-dsp
else
$(warning MusicFX is undefined, please use 'WITH_MUSICFX := true' to make a build with MusicFX.' NOTE:remove audio_effects.conf from device tree')
endif

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/aos/overlay/common

 # Bootanimation
$(call inherit-product, vendor/aos/prebuilt/common/bootanimation/bootanimation.mk)

EXTENDED_POST_PROCESS_PROPS := vendor/aos/tools/aos_process_props.py
