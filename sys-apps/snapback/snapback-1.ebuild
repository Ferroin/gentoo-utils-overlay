# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="LVM2 snapshot based deleted file recovery."
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~mips ~sparc ~ppc"
IUSE=""

DEPEND="
sys-process/cronbase
"
RDEPEND="
${DEPEND}
sys-fs/lvm2
virtual/cron
"

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	exeinto /etc/cron.hourly
	doexe "${FILESDIR}"/${PV}/snapback "${FILESDIR}"/${PV}/snapclean
	doconfd "${FILESDIR}"/${PV}/conf/snapback
	einfo "Make sure you edit the configuration in /etc/conf.d/snapback"
	einfo "Until you edit the configuration and add RUN=1, snapback"
	einfo "won't do anything at all."
}