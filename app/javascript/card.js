const pay = () => {
  const payjp = Payjp('sk_test_ff4979f2c8de9fffe3742201')
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expmonthElement = elements.create('cardExpiry');
  const expyearElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#card-number');
  expmonthElement.mount('#card-exp-month')
  expyearElement.mount('#card-exp-year')
  cvcElement.mount('#card-cvc');

  const submit = document.getElementById("button");

  submit.addEventListener("click", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        numberElement.clear();
        expmonthElement.clear();
        expyearElement.clear();
        cvcElement.clear();
        document.getElementById("charge-form").submit();
      }
    });
  });
};

window.addEventListener("load", pay);