const price = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    const tax = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = tax;
    profitDom.innerHTML = Math.floor(inputValue - tax);
  })
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);