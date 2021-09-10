// JavaScript Document

$(document).ready(function() {  
  $(".animsition").animsition({
    inClass               :   'fade-in', // ロード時のエフェクト
    outClass              :   'fade-out', //離脱時のエフェクト
    inDuration            :    1500, //ロード時の演出時間
    outDuration           :    800, //離脱時の演出時間
    linkElement           :   '.animsition-link', //アニメーションを行う要素
    // e.g. linkElement   :   'a:not([target="_blank"]):not([href^=#])'
    loading               :    true, //ローディングの有効/無効
    loadingParentElement  :   'body', //ローディング要素のラッパー
    loadingClass          :   'animsition-loading', //ローディングのクラス
    unSupportCss          : [ 'animation-duration',
                              '-webkit-animation-duration',
                              '-o-animation-duration'
                            ],
    overlay               :   false, //オーバーレイの有効/無効
    overlayClass          :   'animsition-overlay-slide', //オーバーレイのクラス
    overlayParentElement  :   'body' //オーバーレイ要素のラッパー
  });
});