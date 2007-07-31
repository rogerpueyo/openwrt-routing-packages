# 
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id$

include $(TOPDIR)/rules.mk

PKG_NAME:=batmand
PKG_VERSION:=0.2-rv478
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)_$(PKG_VERSION)_sources
PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION)_sources.tgz
PKG_SOURCE_URL:=http://downloads.open-mesh.net/batman/stable/sources/ \
	http://downloads.open-mesh.net/batman/stable/sources/
PKG_MD5SUM:=b00ad9603e32c85224d5b19f99126ddf
PKG_CAT:=zcat

PKG_INSTALL_DIR:=$(PKG_BUILD_DIR)/ipkg-install

include $(INCLUDE_DIR)/package.mk

define Package/batman
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpthread +kmod-tun
  TITLE:=B.A.T.M.A.N. Better Approach To Mobile Ad-hoc Networking
  URL:=https://www.open-mesh.net/
endef

define Build/Configure
endef

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	CCFLAGS="$(TARGET_CFLAGS)" \
	OFLAGS="$(TARGET_CFLAGS)" \
	NODEBUG=1 \
	UNAME="Linux" \
	INSTALL_PREFIX="$(PKG_INSTALL_DIR)" \
	STRIP="/bin/true" \
	batmand install

define Package/batman/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/batmand $(1)/usr/sbin/
	$(CP) -a ./files/* $(1)/
	chmod -R 755 $(1)/etc/init.d/batman
endef


$(eval $(call BuildPackage,batman))
