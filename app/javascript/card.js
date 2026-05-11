let elementsInstance = null;

const pay = () => {
  const numberFormElement = document.querySelector('#number-form');
  if (!numberFormElement) {
    return;
  }

  const metaTag = document.querySelector('meta[name="payjp-public-key"]');
  const publicKey = metaTag.content;
  
  if (!publicKey || publicKey === '') {
    console.error('Public key is empty or not found!');
    return;
  }
  
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');
  
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  elementsInstance = {
    numberElement,
    expiryElement,
    cvcElement
  };
  
  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        document.getElementById("charge-form").submit();
        return;
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);

        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();        
        document.getElementById("charge-form").submit();
      }
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
