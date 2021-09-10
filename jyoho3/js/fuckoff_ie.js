jQuery(function ($) {
	'use strict';

	function isOldIE() {
		var ua = window.navigator.userAgent.toLowerCase();
		var ver = window.navigator.appVersion.toLowerCase();

		var oldIE = false;

		if (ua.indexOf('msie') > 0) {
			if (ver.indexOf('msie 6.') > 0 ||
				ver.indexOf('msie 7.') > 0 ||
				ver.indexOf('msie 8.') > 0 ||
				ver.indexOf('msie 9.') > 0 ||
				ver.indexOf('msie 10.') > 0 ||
				ver.indexOf('Windows NT 6.3') > 0) {
				oldIE = true;
			}
		}
		return oldIE;
	}

	if (isOldIE()) {
		var ieAlert = `<div class="old-ie-alert" style="background-color: #fbd6dc;text-align: center;padding: 1em 0;border-bottom: 1px solid #f00;">
		<strong>このサイトはお使いのブラウザをサポートしていません</strong>。<br>
		適切に動作するように、最新版の
		<a href="http://www.google.com/chrome" target="_blank" id="keikoku">Chrome</a>、
		<a href="http://www.firefox.com" target="_blank" id="keikoku">Firefox</a>、
		<a href="http://www.firefox.com" target="_blank" id="keikoku">Safari</a>
		を使用してください。</div>`;

		$('body').prepend(ieAlert);
	}

});