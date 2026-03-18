const sideMenu = document.querySelector('aside');
const menuBtn = document.querySelector('#menu_bar');
const closeBtn = document.querySelector('#close_btn');

const themeToggler = document.querySelector('.theme-toggler');

menuBtn.addEventListener('click',()=>{
  sideMenu.style.display = "block"
})
closeBtn.addEventListener('click',()=>{
  sideMenu.style.display = "none"
})

themeToggler.addEventListener('click', () => {
  document.body.classList.toggle('dark-theme-variables');
  const isDarkMode = document.body.classList.contains('dark-theme-variables');
  localStorage.setItem('dark-theme-variables', isDarkMode); // Store dark mode preference
  themeToggler.querySelector('span:nth-child(1)').classList.toggle('active');
  themeToggler.querySelector('span:nth-child(2)').classList.toggle('active');

});
// Apply dark mode if it was enabled before
const isDarkMode = localStorage.getItem('dark-theme-variables') === 'true';
if (isDarkMode) {
  document.body.classList.add('dark-theme-variables');
  themeToggler.querySelector('span:nth-child(1)').classList.add('active');
}