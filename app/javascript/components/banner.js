import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Make it", "Drink it", "Love it"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };
