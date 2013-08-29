# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Automated update script for Gentoo"
HOMEPAGE="https://github.com/Ferroin/gentoo-utils-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm ~ppc ~sparc"
IUSE=""

DEPEND=""
RDEPEND="
>=app-portage/gentoolkit-0.3.0
>=dev-lang/python-3.2
"

src_install() {
	cp "${FILESDIR}"/auto-update-${PV} "${WORK}"/auto-update
	into /usr
	dosbin "${WORK}"/auto-update
	cp "${FILESDIR}"/auto-update-${PV}.conf "${WORK}"/auto-update.conf
	into /etc
	newins "${WORK}"/auto-update.conf
}
