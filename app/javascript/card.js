const pay = () => {
  // 購入ページ以外では実行しない
  const numberFormElement = document.querySelector('#number-form');
  if (!numberFormElement) {
    return;
  }

  // 公開鍵をmetaタグから取得
  const publicKey = document.querySelector('meta[name="payjp-public-key"]').content;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  // 入力フォームの作成
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // 指定したHTML要素に埋め込み
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();

  payjp.createToken(numberElement).then(function (response) {
    if (response.error) {
      console.log(response.error.message);       
    } else {
      // トークン生成に成功した場合のみ、隠しパラメータとしてフォームに追加
      const token = response.id;
      const renderDom = document.getElementById("charge-form");
      const tokenObj = `<input value=${token} name='token' type="hidden">`;
      renderDom.insertAdjacentHTML("beforeend", tokenObj);
    }

    // 入力された情報を消去してセキュリティを確保
    numberElement.clear();
    expiryElement.clear();
    cvcElement.clear();

    // 【重要】成功・失敗に関わらず送信を実行する（Railsのバリデーションを動かすため）
    document.getElementById("charge-form").submit();
  });
});
};

// ページ遷移（Turbo）に対応するための記述
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);